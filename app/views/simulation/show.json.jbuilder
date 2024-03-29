json.set! :simulation do
  json.extract! @simulation, *([:id, :project_id, :name, :description, :final, :status, :created_at, :updated_at] + Simulation.attribute_names)
  json.data_point_results @simulation.data_point_results_hash
end
json.set! :message, @simulation.errors.messages
