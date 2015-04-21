class Project < ActiveRecord::Base
  has_many :simulations
  has_many :geometries
  has_many :reports, as: :reportable
  before_destroy :before_destroy_actions
  validates_presence_of :name

  def before_destroy_actions
    # We cant simply use dependent: :destroy because simulations must be removed first
    # otherwise the directory and jobs won't get removed.
    simulations.destroy_all
    geometries.destroy_all
  end

  def type_info
    "project"
  end

  def path_info
    "NULL"
  end
end
