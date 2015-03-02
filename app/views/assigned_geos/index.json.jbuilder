json.array!(@assigned_geos) do |assigned_geo|
  json.extract! assigned_geo, :id, :create, :show, :index, :update, :delete
  json.url assigned_geo_url(assigned_geo, format: :json)
end
