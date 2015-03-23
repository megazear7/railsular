class Job < ActiveRecord::Base
  include OSC::Machete::SimpleJob
  belongs_to :simulation
  belongs_to :geometry
end
