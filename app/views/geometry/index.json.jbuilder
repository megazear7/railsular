json.set! :geometries do
  json.array! @geometries do |geometry|
    json.extract! geometry, *([:id, :project_id, :name, :description, :final, :geo_type, :created_at, :updated_at, :geo_file_name] + Geometry.geo_attribute_names(geometry.geo_type))
  end
end
json.set! :message, @message
