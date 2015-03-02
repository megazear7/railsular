class GeometryAttr < ActiveRecord::Base
  belongs_to :geometry
  validates_inclusion_of :name, in: []
end
