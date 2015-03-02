class SimulationAttr < ActiveRecord::Base
  belongs_to :simulation
  validates_inclusion_of :name, in: ["measurement_scale", "fluid_type", "kinematic_viscosity", "density", "steps"]
end
