class Geometry < ActiveRecord::Base
  has_attached_file :geo
  belongs_to :project
  has_many :assigned_geometries
  has_many :jobs
  has_many :geometry_attrs

  def self.geo_types
    ["inlet", "outlet", "wall"]
  end

  def self.geo_attribute_names geo_type
    { "inlet"  => [ ],
      "outlet" => [ ],
      "wall"   => [ ]
    }[geo_type]
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
    Geometry.geo_attribute_names(self.geo_type).each do |name|
      if params[name]
        geo_attr = self.geometry_attrs.find_by(name: name)
        geo_attr.value = params[name]
        return false if not geo_attr.save
      end
    end
  end
end