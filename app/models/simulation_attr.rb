class SimulationAttr < ActiveRecord::Base
  belongs_to :simulation
  belongs_to :attribute_descriptor
  validates_inclusion_of :name, in: Simulation.attribute_names

  def name
    attribute_descriptor ? attribute_descriptor.name : nil
  end
end
