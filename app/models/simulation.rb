class Simulation < ActiveRecord::Base
  belongs_to :project
  has_many :assigned_geometries
  has_many :jobs
  has_many :simulation_attrs

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

  self.attribute_names.each do |name|
    define_method name do
      sim_attr = simulation_attrs.find_by(name: name)
      if sim_attr
        sim_attr.value
      else
        nil
      end
    end
  end

  def self.create simulation_params, params
    sim = super simulation_params
    Simulation.attribute_names.each do |name|
      SimulationAttr.create(name: name, value: params[name], simulation_id: sim.id)
    end
    sim
  end

  def update simulation_params, params
    if not self.final
      Simulation.attribute_names.each do |name|
        if params[name]
          sim_attr = self.simulation_attrs.find_by(name: name)
          if sim_attr
            sim_attr.value = params[name]
          else
            SimulationAttr.create(name: name, value: params[name], simulation_id: self.id)
          end
          return false if not sim_attr.save
        end
      end
    end
    super simulation_params
  end
end
