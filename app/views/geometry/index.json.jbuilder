json.set! :geometries do
  json.array! @geometries, *([:id, :project_id, :name, :description, :geo_type, :created_at, :updated_at, :geo_file_name] + Geometry.geo_attribute_names(@geometry.geo_type))
end
json.set! :message, @message
