json.set! :geometries do
  json.array! @geometries, :id, :name, :description, :created_at, :updated_at
end
json.set! :message, @message
