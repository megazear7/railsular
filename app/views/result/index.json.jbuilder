json.set! :results do
  json.array! @results, :id, :x_var, :y_var, :result_type, :generic, :created_at, :updated_at
end
