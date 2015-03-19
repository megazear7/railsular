json.set! :job_descriptor do
  json.extract! @job_descriptor, *([:id, :job_type, :script_number, :test_compute_resources, :prod_compute_resources, :test_walltime, :prod_walltime])
end
