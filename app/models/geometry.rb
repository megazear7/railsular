class Geometry < ActiveRecord::Base
  has_attached_file :geo
  belongs_to :project
  has_many :assigned_geometries
  has_many :jobs
  has_many :geometry_attr
end
