json.set! :assigned_geometries do
  json.array! @assigned_geos, :id, :geometry_id, :simulation_id, :vx, :vy, :vz, :created_at, :updated_at
end
json.set! :message, @message
