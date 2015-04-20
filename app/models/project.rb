class Project < ActiveRecord::Base
  has_many :simulations, dependent: :destroy
  has_many :geometries, dependent: :destroy
  validates_presence_of :name
end
