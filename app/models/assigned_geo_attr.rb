class AssignedGeoAttr < ActiveRecord::Base
  belongs_to :assigned_geometry
  belongs_to :attribute_descriptor
  validates_inclusion_of :name, in: AssignedGeometry.all_attribute_names

  def name
    attribute_descriptor ? attribute_descriptor.name : nil
  end
end
