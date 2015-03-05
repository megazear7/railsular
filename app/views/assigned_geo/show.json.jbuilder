json.set! :assigned_geometry do
  json.extract! @assigned_geo, *([:id, :geometry_id, :simulation_id, :created_at, :updated_at] + AssignedGeometry.assigned_geo_attribute_names(@assigned_geo.geometry.geo_type))
end
json.set! :message, @message
