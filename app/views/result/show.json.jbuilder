json.set! :result do
  json.extract! @result, :id, :x_var, :y_var, :result_type, :generic, :created_at, :updated_at
end
