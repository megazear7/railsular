json.set! :geometries do
  json.array! @geometries do |geometry|
    json.extract! geometry, *([:id, :project_id, :description, :status, :final, :geo_type, :created_at, :updated_at, :geo_file_name] + Geometry.geo_attribute_names(geometry.geo_type))
    json.results geometry.complete_results_hash
  end
end
