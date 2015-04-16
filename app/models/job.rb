class Job < ActiveRecord::Base
  include OSC::Machete::SimpleJob
  belongs_to :simulation
  belongs_to :geometry

  def job
    OSC::Machete::Job.new(pbsid: pbsid, script: job_path)
  end
end
