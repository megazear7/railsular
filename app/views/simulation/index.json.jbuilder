json.set! :simulations do
  json.array! @simulations, *([:id, :project_id, :name, :description, :final, :status, :created_at, :updated_at] + Simulation.attribute_names)
end
