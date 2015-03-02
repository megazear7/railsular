json.array!(@simulations) do |simulation|
  json.extract! simulation, :id, :create, :show, :index, :update, :delete
  json.url simulation_url(simulation, format: :json)
end
