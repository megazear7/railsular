json.set! :assigned_geometry do
  json.extract! @assigned_geo, :id, :geometry_id, :simulation_id, :vx, :vy, :vz, :created_at, :updated_at
end
json.set! :message, @message