json.array!(@geometry_types) do |geometry_type|
  json.extract! geometry_type, :id, :create, :show, :index, :update, :delete
  json.url geometry_type_url(geometry_type, format: :json)
end
