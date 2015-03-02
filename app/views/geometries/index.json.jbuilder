json.array!(@geometries) do |geometry|
  json.extract! geometry, :id, :create, :show, :index, :update, :delete
  json.url geometry_url(geometry, format: :json)
end
