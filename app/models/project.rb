class Project < ActiveRecord::Base
  has_many :simulations
  has_many :geometries
  validates_presence_of :name
end
