json.set! :job_descriptors do
  json.array! @job_descriptors do |job_descriptor|
    json.extract! job_descriptor, *([:id, :job_type, :script_number, :test_compute_resources, :prod_compute_resources, :test_walltime, :prod_walltime])
  end
end
