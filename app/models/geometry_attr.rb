class GeometryAttr < ActiveRecord::Base
  belongs_to :geometry
  validates_inclusion_of :name, in: Geometry.all_attribute_names
end
