class GeometryAttr < ActiveRecord::Base
  belongs_to :geometry
  belongs_to :attribute_descriptor
  validates_inclusion_of :name, in: Geometry.all_attribute_names

  def name
    attribute_descriptor ? attribute_descriptor.name : nil
  end
end
