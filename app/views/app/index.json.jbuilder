json.set! :apps do
  json.array! @apps, :id, :name, :app_hex_code, :test, :app_bin, :batch_queue, :iterative, :created_at, :updated_at
end
