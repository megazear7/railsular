class Simulation < ActiveRecord::Base
  belongs_to :project
  has_many :assigned_geometries
  has_many :jobs
  has_many :simulation_attrs

  def self.attribute_details
    # the index field is simply to let the UI designer have some understanding of 
    # how to display the fields. Low numbers are higher priority. sub values
    # represent that they should be grouped together. So for example field with 
    # index "1" should be its own group, fields with index's "2.1", "2.2" and "2.3" are goruped together
    {
      "measurement_scale" => {
        "type" => "select",
        "values" => ["mm", "cm", "inch"],
        "index" => "1"
      },
      "fluid_type" => {
        "type" => "select",
        "values" => ["water", "honey"],
        "index" => "2"
      },
      "kinematic_viscosity" => {
        "type" => "text-input",
        "values" => "", # todo maybe use a regex for this? or maybe just "integers" or "float" with a range?
        "index" => "3"
      },
      "density" => {
        "type" => "text-input",
        "values" => "",
        "index" => "4"
      },
      "steps" => {
        "type" => "text-input",
        "values" => "",
        "index" => "5"
      }
    }
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
