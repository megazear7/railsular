class GeometryType < ActiveRecord::Base
  has_many :attribute_descriptors
  has_many :geometries
end
