class Job < ActiveRecord::Base
  include OSC::Machete::SimpleJob
  belongs_to :simulation
  belongs_to :geometry

  def parent
    if simulation
      simulation
    elsif geometry
      geometry
    end
  end

  def script_path
    parent.job_directory_path
  end

  def job
    OSC::Machete::Job.new(pbsid: pbsid, script: script_path)
  end
end
