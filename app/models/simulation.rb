class Simulation < ActiveRecord::Base
  belongs_to :project
  has_many :assigned_geometries
  has_many :geometries, through: :assigned_geometries
  has_many :jobs
  has_many :simulation_attrs
  after_initialize :add_attr_methods

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
    # TODO calculate this based off of the has_many jobs relationship
    final ? "Queued" : "Not Submitted"
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
          sim_attr = self.simulation_attrs.find_by(attribute_descriptor_id: AttributeDescriptor.find_by(name: name).id)
          if sim_attr
            sim_attr.value = params[name]
          else
            sim_attr = SimulationAttr.create(attribute_descriptor_id: AttributeDescriptor.find_by(name: name).id, value: params[name], simulation_id: self.id)
          end
          return false if not sim_attr.save
        end
      end
    end
    super simulation_params
  end

  def job_directory_name
    "ts_app_"+App.find(1).app_hex_code+"_user_id_"+id.to_s
  end

  def job_directory_path
    File.join(ENV['HOME'], "/crimson_files/", App.find(1).name.downcase.tr(' ', '_'), job_directory_name)
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

  def test
    template_file = File.open(template_file_path)
    Mustache.render(template_file.read,
    {
      batch_job_name: "my job name",
      test: true,
      app_bin: "/path/to/bin",
      batch_queue: "@oak",
      test_compute_resources: "aaaa",
      prod_compute_resources: "bbbb",
      test_walltime: "cccc",
      prod_walltime: "dddd",
      script_number: "1"
    })
  end

  def submit
    Dir.mkdir(job_directory_path)

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
        test_compute_resources: descr.test_compute_resources,
        prod_compute_resources: descr.prod_compute_resources,
        test_walltime: descr.test_walltime,
        prod_walltime: descr.prod_walltime,
        script_number: descr.script_number,
        should_setup: descr.script_number==1
      })
      File.write(batch_file_path(descr.script_number), tmp)
    end

    config = {
      name: name,
      geometry_settings: [

      ],
      simulation_settings: {
      }
    }
    Simulation.attribute_names.each do |attribute|
      puts attribute
      config[:simulation_settings][attribute] = send(attribute)
    end
    assigned_geometries.each_with_index do |assigned_geo, index|
      geo = config[:geometry_settings][index] = {}
      geo[:type] = assigned_geo.geometry.geometry_type.name
      geo[:filename] = "geometry_#{assigned_geo.geometry.id}.stl"
      AssignedGeometry.assigned_geo_attribute_names(assigned_geo.geometry.geometry_type.name).each do |attribute|
        puts attribute
        geo[attribute] = assigned_geo.send(attribute)
      end
      Geometry.geo_attribute_names(assigned_geo.geometry.geometry_type.name).each do |attribute|
        puts attribute
        geo[attribute] = assigned_geo.geometry.send(attribute)
      end
    end
    File.write(config_file_path, config.to_json)
    
    Dir.mkdir(File.join(job_directory_path, "geometry"))

    self.geometries.each do |geometry|
      FileUtils.cp geometry.geo.path, File.join(job_directory_path, "geometry", "geometry_#{geometry.id}.stl")
    end

    # TODO use machete to create a job object (saved in our jobs table) for each batch file in the /job directory
    # with later jobs being dependent on earlier jobs
    jobs = []
    JobDescriptor.where(job_type: "simulation").each_with_index do |descr, index|
      jobs << OSC::Machete::Job.new(script: batch_file_path(descr.script_number))
      jobs[index].afterany(jobs[index-1]) unless index == 0
    end

    jobs[0].submit
  end
end
