class AssignedGeoAttr < ActiveRecord::Base
  belongs_to :assigned_geometry
  validates_inclusion_of :name, in: AssignedGeometry.all_attribute_names
end
