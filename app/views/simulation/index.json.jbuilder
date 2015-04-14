json.set! :simulations do
  json.array! @simulations do |simulation|
    json.extract! simulation, *([:id, :project_id, :name, :description, :final, :status, :created_at, :updated_at] + Simulation.attribute_names)
    json.data_point_results simulation.data_point_results_hash
  end
end
