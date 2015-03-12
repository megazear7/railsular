json.set! :geometry_types do
  json.array! @geometry_types do |geometry_type|
    json.extract! geometry_type, *([:id, :name, :created_at, :updated_at])
  end
end
json.set! :message, @message
