json.set! :simulation do
  json.extract! @simulation, *([:id, :project_id, :name, :description, :final, :status, :created_at, :updated_at] + Simulation.attribute_names)
end
json.set! :message, @message
