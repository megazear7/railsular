json.set! :assigned_geometries do
  json.array! @assigned_geos, *([:id, :geometry_id, :simulation_id, :created_at, :updated_at] + AssignedGeometry.assigned_geo_attribute_names(@assigned_geo.geometry.geo_type))
end
json.set! :message, @message
