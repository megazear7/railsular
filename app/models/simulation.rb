class Simulation < ActiveRecord::Base
  belongs_to :project
  has_many :assigned_geometries
  has_many :jobs
  has_many :simulation_attrs

  def self.attribute_names
    ["measurement_scale", "fluid_type", "kinematic_viscosity", "density", "steps"]
  end

  def status
    # TODO calculate this based off of the has_many jobs relationship
    final ? "Queued" : "Not Submitted"
  end

  self.attribute_names.each do |name|
    define_method name do
      simulation_attrs.find_by(name: name).value
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
          sim_attr.value = params[name]
          return false if not sim_attr.save
        end
      end
    end
    super simulation_params
  end
end
