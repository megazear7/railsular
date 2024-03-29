class Simulation < ActiveRecord::Base
  belongs_to :project
  has_many :reports, as: :reportable
  has_many :assigned_geometries, dependent: :destroy
  has_many :geometries, through: :assigned_geometries
  has_many :jobs, dependent: :destroy
  has_many :simulation_attrs
  has_and_belongs_to_many :results
  after_initialize :add_attr_methods
  before_destroy :remove_jobs, prepend: true

  def remove_jobs
    FileUtils.rm_rf job_directory_path
    jobs.each do |job|
      job.job.delete
    end
  end

  def add_attr_methods
    Simulation.attribute_names.each do |name|
      self.class.send(:define_method, name) do
        sim_attr = simulation_attrs.find_by(attribute_descriptor_id: AttributeDescriptor.find_by(name: name).id)
        if sim_attr
          sim_attr.value
        else
          nil
        end
      end
    end
  end

  def self.attribute_details
    ret = {}
    AttributeDescriptor.where(usage: "simulation").each do |attr_desc|
      ret[attr_desc.name] = {
        "type" => attr_desc.attr_type,
        "index" => attr_desc.display,
        "validation" => attr_desc.validation,
      }
      ret[attr_desc.name]["values"] = []
      attr_desc.attribute_descriptor_values.each do |val|
        ret[attr_desc.name]["values"] << val.value
      end
    end
    ret
  end

  def self.attribute_names
    self.attribute_details.keys
  end

  def status
    if final
      ret = "Queued"
      ret = "Running" if self.jobs.where(status: "R").exists?
      ret = "Running" if self.jobs.where(status: "C").exists?

      if JobDescriptor.where(job_type: "simulation").count == self.jobs.count
        all_complete = true
        self.jobs.each do |job|
          all_complete = false if job.status != "C"
        end
        ret = "Complete" if all_complete
      end

      ret = "Complete" if JobDescriptor.where(job_type: "simulation").count == 0

      return ret
    else
      "Not Submitted"
    end
  end

  def self.create simulation_params, params
    sim = super simulation_params
    Simulation.attribute_names.each do |name|
      SimulationAttr.create(attribute_descriptor_id: AttributeDescriptor.find_by(name: name).id, value: params[name], simulation_id: sim.id)
    end
    sim
  end

  def update simulation_params, params
    if not self.final
      Simulation.attribute_names.each do |name|
        if params[name]
          attr_desc = AttributeDescriptor.find_by(name: name)
          sim_attr = self.simulation_attrs.find_by(attribute_descriptor_id: attr_desc.id)
          regex = Regexp.new attr_desc.validation
          if regex.match params[name]
            if sim_attr
              sim_attr.value = params[name]
            else
              sim_attr = SimulationAttr.create(attribute_descriptor_id: attr_desc.id, value: params[name], simulation_id: self.id)
            end
            if not sim_attr.save
              return false 
            end
          else
            errors.add name, "#{name.titleize} attribute must follow this regex: #{attr_desc.validation}"
            return false
          end
        end
      end
    end
    super simulation_params
  end

  def type_info
    "simulation"
  end

  def path_info
    "path: #{job_directory_path}"
  end

  def job_directory_name
    "ts_app_" + App.find(1).app_hex_code + "_" + ENV["USER"] + "_s" + id.to_s
  end

  def job_directory_path
    File.join(ENV['HOME'], "/crimson_files/", App.find(1).name.downcase.tr(' ', '_'), job_directory_name)
  end

  def results_zip_file_path
    File.join(job_directory_path, "results", "results.zip")
  end

  def data_points_json_file_path
    File.join(job_directory_path, "results", "data", "data_points.json")
  end

  def data_point_results
    if data_points_json_file_path and File.exist?(data_points_json_file_path)
      File.open(data_points_json_file_path).read
    else
      nil
    end
  end

  def data_point_results_hash
    data_point_results ? JSON.parse(data_point_results) : nil
  end

  def images_directory_path
    File.join(job_directory_path, "results", "images")
  end

  def image_file_path variable_name, component_direction, view
    File.join(images_directory_path, variable_name, component_direction, view)
  end

  def movies_directory_path
    File.join(job_directory_path, "results", "movies")
  end

  def frame_file_path slice_normal, variable_name, component_direction, frame
    File.join(movies_directory_path, slice_normal, variable_name, component_direction, (frame.to_i-1).to_s.rjust(4, '0') + ".png")
  end

  def rendered_geometry_directory_path geo
    File.join(geo.job_directory_path, 'results', 'geometry')
  end

  def rendered_data_directory_path geo
    File.join(geo.job_directory_path, 'results', 'data')
  end

  def batch_file_path script_number
    File.join(job_directory_path, "batch_"+script_number.to_s+".sh")
  end

  def config_file_path
    File.join(job_directory_path, "config.json")
  end

  def batch_job_name script_number
    job_directory_name+"_"+script_number.to_s
  end

  def template_file_path
    File.join(Rails.root, "job_template.sh.mustache")
  end

  def add_batch_files
    app = App.find(1)
    test = app.test
    app_bin = app.app_bin
    batch_queue = app.batch_queue
    
    JobDescriptor.where(job_type: "simulation").each do |descr|
      template_file = File.open(template_file_path)
      tmp = Mustache.render(template_file.read,
      {
        batch_job_name: batch_job_name(descr.script_number),
        test: test,
        app_bin: app_bin,
        batch_queue: batch_queue,
        setup_method: descr.setup_method,
        test_compute_resources: descr.test_compute_resources,
        prod_compute_resources: descr.prod_compute_resources,
        test_walltime: descr.test_walltime,
        prod_walltime: descr.prod_walltime,
        script_number: descr.script_number,
        should_setup: descr.setup_method.present?
      })
      File.write(batch_file_path(descr.script_number), tmp)
    end
  end

  def add_config_file
    config = {
      name: name,
      geometry_settings: [

      ],
      simulation_settings: {
        attributes: {
        }
      }
    }
    Simulation.attribute_names.each do |attribute|
      config[:simulation_settings][:attributes][attribute] = send(attribute)
    end
    assigned_geometries.each_with_index do |assigned_geo, index|
      config[:geometry_settings][index] = {
        attributes: {},
        pre_processing_data: {
          data: {},
          rendered_geometries: [] 
        }
      }
      geo = config[:geometry_settings][index]
      geo[:type] = assigned_geo.geometry.geometry_type.name
      geo[:filename] = assigned_geo.geometry.geo_file_name
      AssignedGeometry.assigned_geo_attribute_names(assigned_geo.geometry.geometry_type.name).each do |attribute|
        geo[:attributes][attribute] = assigned_geo.send(attribute)
      end
      Geometry.geo_attribute_names(assigned_geo.geometry.geometry_type.name).each do |attribute|
        geo[:attributes][attribute] = assigned_geo.geometry.send(attribute)
      end

      geo[:pre_processing_data][:data] = assigned_geo.geometry.results_hash

      # for each rendered geometry, add an entry to the rendered geometries array
      Dir.glob(rendered_data_directory_path(assigned_geo.geometry) + '/*.json') do |file|
        next if File.basename(file, ".json") == File.basename(assigned_geo.geometry.geo_file_name, ".stl")
        r_geo = {
          filename: File.basename(file, ".json") + File.extname(assigned_geo.geometry.geo_file_name)
        }
        r_geo[:data] = JSON.parse(File.open(File.join(file)).read)
        geo[:pre_processing_data][:rendered_geometries].push r_geo
      end

    end
    File.write(config_file_path, config.to_json)
  end

  def add_geometry_files
    Dir.mkdir(File.join(job_directory_path, "geometry"))

    self.geometries.each do |geometry|
      FileUtils.cp geometry.geo.path, File.join(job_directory_path, "geometry", geometry.geo_file_name)
      Dir.foreach(rendered_geometry_directory_path(geometry)) do |file|
        next if file == "." or file == ".."
        FileUtils.cp File.join(rendered_geometry_directory_path(geometry), file), File.join(job_directory_path, "geometry", file)
      end
    end
  end

  def submit
    Dir.mkdir(job_directory_path)
    add_batch_files
    add_config_file
    add_geometry_files

    jobs = []
    JobDescriptor.where(job_type: "simulation").order(:script_number).each_with_index do |descr, index|
      jobs << OSC::Machete::Job.new(script: batch_file_path(descr.script_number))
      jobs[index].afterany(jobs[index-1]) unless index == 0

      self.jobs.create(pbsid: jobs[index].pbsid, job_path: jobs[index].path.to_s, script_name: jobs[index].script_name, status: jobs[index].status)

      jobs[index].submit
    end

    jobs.each do |machete_job|
      job = self.jobs.find_by(script_name: machete_job.script_name)
      job.pbsid = machete_job.pbsid
      job.save
    end
  end

  def self.curve_variable_names simulations
    lists = [ ]
    simulations.each do |sim|
      lists.push File.open(Result.csv_file_path(sim), &:gets).split(",")
    end
    lists.flatten.uniq
  end

  def self.image_variable_names simulations
    lists = [ ]
    simulations.each do |sim|
      lists.push Dir.entries(sim.images_directory_path)
    end
    variable_names = lists.flatten.uniq
    variable_names.delete('.')
    variable_names.delete('..')
    variable_names
  end

  def self.image_component_directions simulations, variable_name
    lists = [ ]
    simulations.each do |sim|
      lists.push Dir.entries(File.join(sim.images_directory_path, variable_name))
    end
    component_directions = lists.flatten.uniq
    component_directions.delete('.')
    component_directions.delete('..')
    component_directions
  end

  def self.image_views simulations, variable_name, component_direction
    lists = [ ]
    simulations.each do |sim|
      lists.push Dir.entries(File.join(sim.images_directory_path, variable_name, component_direction))
    end
    views = lists.flatten.uniq
    views.delete('.')
    views.delete('..')
    views.map! do |view|
      view = File.basename(view, ".png")
    end
    views
  end

  def self.movie_slice_normals simulations
    lists = [ ]
    simulations.each do |sim|
      lists.push Dir.entries(sim.movies_directory_path)
    end
    slice_normals = lists.flatten.uniq
    slice_normals.delete('.')
    slice_normals.delete('..')
    slice_normals
  end

  def self.movie_variable_names simulations, slice_normal
    lists = [ ]
    simulations.each do |sim|
      lists.push Dir.entries(File.join(sim.movies_directory_path, slice_normal))
    end
    variable_names = lists.flatten.uniq
    variable_names.delete('.')
    variable_names.delete('..')
    variable_names
  end

  def self.movie_component_directions simulations, slice_normal, variable_name
    lists = [ ]
    simulations.each do |sim|
      lists.push Dir.entries(File.join(sim.movies_directory_path, slice_normal, variable_name))
    end
    component_directions = lists.flatten.uniq
    component_directions.delete('.')
    component_directions.delete('..')
    component_directions
  end

  def self.movie_frame_count simulations, slice_normal, variable_name, component_direction
    lists = [ ]
    simulations.each do |sim|
      lists.push Dir.entries(File.join(sim.movies_directory_path, slice_normal, variable_name, component_direction))
    end
    frames = lists.flatten.uniq
    frames.delete('.')
    frames.delete('..')
    frames.count
  end
end
