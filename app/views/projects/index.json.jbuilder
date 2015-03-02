json.array!(@projects) do |project|
  json.extract! project, :id, :create, :show, :index, :update, :delete
  json.url project_url(project, format: :json)
end
