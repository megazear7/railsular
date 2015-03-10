class Geometry < ActiveRecord::Base
  has_attached_file :geo
  belongs_to :project
  has_many :assigned_geometries
  has_many :jobs
  has_many :geometry_attrs

  def self.geo_attributes
    { "inlet"  => {
      },
      "outlet" => {
      },
      "wall"   => {
      }
    }
  end

  def self.geo_types
    Geometry.geo_attributes.keys
  end

  def self.geo_attribute_names geo_type
    Geometry.geo_attributes[geo_type].keys
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

  self.geo_types.each do |geo_type|
    self.geo_attribute_names(geo_type).each do |name|
      define_method name do
        if geometry_attrs.find_by(name: name)
          geometry_attrs.find_by(name: name).value
        else
          nil
        end
      end
    end
  end

  def self.create geometry_params, params
    geo = super geometry_params
    Geometry.geo_attribute_names(geo.geo_type).each do |name|
      GeometryAttr.create(name: name, value: params[name], geometry_id: geo.id)
    end
    geo
  end

  def update geometry_params, params
    super geometry_params
    if not self.final
      Geometry.geo_attribute_names(self.geo_type).each do |name|
        if params[name]
          geo_attr = self.geometry_attrs.find_by(name: name)
          geo_attr.value = params[name]
          return false if not geo_attr.save
        end
      end
    else
      return true
    end
  end
end
