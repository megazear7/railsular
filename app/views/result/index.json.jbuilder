json.set! :results do
  json.array! @results, :id, :simulation_id, :generic, :created_at, :updated_at
end
