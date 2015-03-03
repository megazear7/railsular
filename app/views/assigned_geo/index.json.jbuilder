json.set! :assigned_geos do
  json.array! @assigned_geos, :id, :geometry_id, :simulation_id, :created_at, :updated_at
end
json.set! :message, @message
