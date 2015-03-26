class Geometry < ActiveRecord::Base
  has_attached_file :geo
  do_not_validate_attachment_file_type :geo
  belongs_to :project
  belongs_to :geometry_type
  has_many :assigned_geometries
  has_many :jobs
  has_many :geometry_attrs
  after_initialize :add_attr_methods

  validate :file_name_is_unique

  def file_name_is_unique
    if geo_file_name
      geos = Geometry.where(geo_file_name: geo_file_name, project_id: project_id)
      if geos.count >= 2
        errors.add :geo_file_name, "file with name of #{geo_file_name} already exists"
      elsif geos.count == 1 and not id
        errors.add :geo_file_name, "file with name of #{geo_file_name} already exists"
      elsif geos.count == 1 and id and geos.first.id != id
        errors.add :geo_file_name, "file with name of #{geo_file_name} already exists"
      end
    end
  end

  def add_attr_methods
    Geometry.geo_types.each do |geo_type|
      Geometry.geo_attribute_names(geo_type).each do |name|
        self.class.send(:define_method, name) do
          geo_attr = geometry_attrs.find_by(attribute_descriptor_id: AttributeDescriptor.find_by(name: name).id)
          if geo_attr
            geo_attr.value
          else
            nil
          end
        end
      end
    end
  end

  def geo_type
    geometry_type.name
  end

  def self.geo_attributes
    ret = {}
    GeometryType.all.each do |type|
      ret[type.name] = {}
      type.attribute_descriptors.where(usage: "geometry").each do |attr_desc|
        ret[type.name][attr_desc.name] = {
          "type" => attr_desc.attr_type,
          "index" => attr_desc.display,
          "validation" => attr_desc.validation,
        }
        ret[type.name][attr_desc.name]["values"] = []
        attr_desc.attribute_descriptor_values.each do |val|
          ret[type.name][attr_desc.name]["values"] << val.value
        end
      end
    end
    ret
  end

  def self.geo_types
    Geometry.geo_attributes.keys
  end

  def self.geo_attribute_names geo_type
    if Geometry.geo_attributes[geo_type]
      Geometry.geo_attributes[geo_type].keys
    else
      []
    end
  end

  def self.all_attribute_names
    full_list = []
    Geometry.geo_types.each do |geo_type|
      geo_attribute_names(geo_type).each do |attr|
        full_list << attr
      end
    end
    full_list
  end

  def self.create geometry_params, params
    geo = super geometry_params
    Geometry.geo_attribute_names(geo.geo_type).each do |name|
      GeometryAttr.create(attribute_descriptor_id: AttributeDescriptor.find_by(name: name).id, value: params[name], geometry_id: geo.id)
    end
    geo
  end

  def update geometry_params, params
    return false if not super geometry_params
    if not self.final
      Geometry.geo_attribute_names(self.geo_type).each do |name|
        if params[name]
          geo_attr = self.geometry_attrs.find_by(attribute_descriptor_id: AttributeDescriptor.find_by(name: name).id)
          if geo_attr
            geo_attr.value = params[name]
          else
            geo_attr = GeometryAttr.create(attribute_descriptor_id: AttributeDescriptor.find_by(name: name).id, value: params[name], geometry_id: self.id)
          end
          return false if not geo_attr.save
        end
      end
    else
      return true
    end
  end

  def name
    if geo_file_name
      File.basename(geo_file_name, File.extname(geo_file_name))
    else
      "No File Uploaded"
    end
  end

  def status
    if final
      ret = "Queued"
      ret = "Running" if self.jobs.where(status: "R").exists?
      ret = "Running" if self.jobs.where(status: "C").exists?

      if JobDescriptor.where(job_type: self.geometry_type.name).count == self.jobs.count
        all_complete = true
        self.jobs.each do |job|
          all_complete = false if job.status != "C"
        end
        ret = "Complete" if all_complete
      end

      ret = "Complete" if JobDescriptor.where(job_type: self.geometry_type.name).count == 0

      return ret
    else
      "Not Submitted"
    end
  end

  def job_directory_name
    # TODO replace user_id with the actual users id
    "ts_app_"+App.find(1).app_hex_code+"_user_id_"+id.to_s
  end

  def job_directory_path
    File.join(ENV['HOME'], "/crimson_files/", App.find(1).name.downcase.tr(' ', '_'), "preprocessing_jobs", job_directory_name)
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
    
    JobDescriptor.where(job_type: self.geometry_type.name).each do |descr|
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
      geometry_settings: {
        attributes: {
        }
      }
    }

    geo = config[:geometry_settings]
    geo[:type] = self.geometry_type.name
    geo[:filename] = "geometry_#{self.id}.stl"
    Geometry.geo_attribute_names(self.geometry_type.name).each do |attribute|
      geo[:attributes][attribute] = self.send(attribute)
    end

    File.write(config_file_path, config.to_json)
  end

  def add_geometry_files
    Dir.mkdir(File.join(job_directory_path, "geometry"))

    FileUtils.cp self.geo.path, File.join(job_directory_path, "geometry", "geometry_#{self.id}.stl")
  end

  def submit
    Dir.mkdir(job_directory_path)
    add_batch_files
    add_config_file
    add_geometry_files

    jobs = []
    JobDescriptor.where(job_type: self.geometry_type.name).each_with_index do |descr, index|
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
end
