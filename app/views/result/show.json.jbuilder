json.set! :result do
  json.extract! @result, :id, :simulation_id, :generic, :created_at, :updated_at
end
