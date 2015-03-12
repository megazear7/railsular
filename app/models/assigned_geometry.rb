class AssignedGeometry < ActiveRecord::Base
  belongs_to :simulation
  belongs_to :geometry
  has_many :assigned_geo_attrs
  after_initialize :add_attr_methods

  def add_attr_methods
    Geometry.geo_types.each do |geo_type|
      AssignedGeometry.assigned_geo_attribute_names(geo_type).each do |name|
        self.class.send(:define_method, name) do
          if assigned_geo_attrs.find_by(name: name)
            assigned_geo_attrs.find_by(name: name).value
          else
            nil
          end
        end
      end
    end
  end

  def self.assigned_geo_attributes
    ret = {}
    GeometryType.all.each do |type|
      ret[type.name] = {}
      type.attribute_descriptors.where(usage: "assigned_geometry").each do |attr_desc|
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

  def self.assigned_geo_attribute_names geo_type
    if AssignedGeometry.assigned_geo_attributes[geo_type]
      AssignedGeometry.assigned_geo_attributes[geo_type].keys
    else
      []
    end
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
        if assigned_geo_attr
          assigned_geo_attr.value = params[name]
        else
          assigned_geo_attr = AssignedGeoAttr.create(name: name, value: params[name], assigned_geometry_id: self.id)
        end
        return false if not assigned_geo_attr.save
      end
    end
    return true
  end
end
