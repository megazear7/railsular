class Job < ActiveRecord::Base
  belongs_to :simulation
  belongs_to :geometry
end
