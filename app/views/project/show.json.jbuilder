json.set! :project do
  json.extract! @project, :id, :name, :description, :created_at, :updated_at
end
