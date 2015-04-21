json.set! :reports do
  json.array! @reports, :id, :message, :reportable_id, :reportable_type, :created_at, :updated_at
end
