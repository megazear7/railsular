json.set! :app do
  json.extract! @app, :id, :name, :email, :app_hex_code, :test, :app_bin, :batch_queue, :iterative, :created_at, :updated_at
end
