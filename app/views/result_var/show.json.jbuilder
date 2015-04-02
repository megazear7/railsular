json.set! :result_var do
  json.extract! @result_var, :id, :name, :app_id, :created_at, :updated_at
end
