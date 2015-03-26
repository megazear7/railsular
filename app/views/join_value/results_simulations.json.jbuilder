json.set! :result_simulations do
  json.array! @result_simulations, :result_id, :simulation_id
end
