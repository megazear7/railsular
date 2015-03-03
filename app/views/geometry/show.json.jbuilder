json.set! :geometry do
  json.extract! @geometry, :id, :name, :description, :created_at, :updated_at
end
json.set! :message, @message
