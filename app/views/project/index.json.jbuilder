json.set! :projects do
  json.array! @projects, :id, :name, :description, :created_at, :updated_at
end
json.set! :message, @message
