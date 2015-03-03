class AssignedGeometry < ActiveRecord::Base
  belongs_to :simulation
  belongs_to :geometry
  has_many :assigned_geo_attrs
end
