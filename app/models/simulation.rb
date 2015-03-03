class Simulation < ActiveRecord::Base
  belongs_to :project
  has_many :assigned_geometries
  has_many :jobs
  has_many :simulation_attrs

  def self.create simulation_params, params
    sim = super simulation_params
    Simulation.attribute_names.each do |name|
      SimulationAttr.create(name: name, value: params[name], simulation_id: sim.id)
    end
    sim
  end

  def update simulation_params, params
    super simulation_params
    Simulation.attribute_names.each do |name|
      if params[name]
        sim_attr = self.simulation_attrs.find_by(name: name)
        sim_attr.value = params[name]
        return false if not sim_attr.save
      end
    end
  end

  def self.attribute_names
    ["measurement_scale", "fluid_type", "kinematic_viscosity", "density", "steps"]
  end

  def measurement_scale
    simulation_attrs.find_by(name: "measurement_scale").value
  end

  def fluid_type
    simulation_attrs.find_by(name: "fluid_type").value
  end
  
  def kinematic_viscosity
    simulation_attrs.find_by(name: "kinematic_viscosity").value
  end
  
  def density
    simulation_attrs.find_by(name: "density").value
  end
  
  def steps
    simulation_attrs.find_by(name: "steps").value
  end

end
