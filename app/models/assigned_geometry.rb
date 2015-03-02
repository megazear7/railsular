class AssignedGeometry < ActiveRecord::Base
  belongs_to :simulation
  belongs_to :geometry
end
