class Project < ActiveRecord::Base
  has_many :simulations
  has_many :geometries
end
