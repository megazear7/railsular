class AssignedGeometry < ActiveRecord::Base
  belongs_to :simulation
  belongs_to :geometry
  has_many :assigned_geo_attrs

  def self.assigned_geo_attributes
    # the only duplicated information is here in geo type names. The "inlet", "outlet", "wall" list is listed both here and in the geometry model
    { "inlet"  => {
        "vx" => "free-input", 
        "vy" => "free-input", 
        "vz" => "free-input"
      },
      "outlet" => {
      },
      "wall"   => {
      }
    }
  end

  def self.assigned_geo_attribute_names geo_type
    AssignedGeometry.assigned_geo_attributes[geo_type].keys
  end

  def self.all_attribute_names
    full_list = []
    Geometry.geo_types.each do |geo_type|
      assigned_geo_attribute_names(geo_type).each do |attr|
        full_list << attr
      end
    end
    full_list
  end

  Geometry.geo_types.each do |geo_type|
    self.assigned_geo_attribute_names(geo_type).each do |name|
      define_method name do
        if assigned_geo_attrs.find_by(name: name)
          assigned_geo_attrs.find_by(name: name).value
        else
          nil
        end
      end
    end
  end

  def self.create assigned_geo_params, params
    assigned_geo = super assigned_geo_params
    AssignedGeometry.assigned_geo_attribute_names(assigned_geo.geometry.geo_type).each do |name|
      AssignedGeoAttr.create(name: name, value: params[name], assigned_geometry_id: assigned_geo.id)
    end
    assigned_geo
  end

  def update assigned_geo_params, params
    # notice that we dont user super because we don't want simulation_id or geometry_id to change
    AssignedGeometry.assigned_geo_attribute_names(self.geometry.geo_type).each do |name|
      if params[name]
        assigned_geo_attr = self.assigned_geo_attrs.find_by(name: name)
        assigned_geo_attr.value = params[name]
        return false if not assigned_geo_attr.save
      end
    end
    return true
  end
end
