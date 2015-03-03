json.set! :geometry do
  json.extract! @geometry, :id, :name, :description, :geo_type, :created_at, :updated_at
end
json.set! :message, @message
