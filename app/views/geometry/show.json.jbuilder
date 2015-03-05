json.set! :geometry do
  json.extract! @geometry, :id, :project_id, :name, :description, :geo_type, :created_at, :updated_at, :geo_file_name
end
json.set! :message, @message
