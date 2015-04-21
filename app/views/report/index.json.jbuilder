json.set! :reports do
  json.array! @reports, :id, :name, :description, :created_at, :updated_at
end
