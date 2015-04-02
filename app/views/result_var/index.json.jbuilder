json.set! :result_vars do
  json.array! @result_vars, :id, :name, :app_id, :created_at, :updated_at
end
