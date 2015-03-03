class SimulationAttr < ActiveRecord::Base
  belongs_to :simulation
  validates_inclusion_of :name, in: Simulation.attribute_names
end
