json.set! :geometry_type do
  json.extract! @geometry_type, *([:id, :name, :created_at, :updated_at])
end
json.set! :message, @message
