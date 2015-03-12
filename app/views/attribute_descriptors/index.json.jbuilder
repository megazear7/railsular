json.array!(@attribute_descriptors) do |attribute_descriptor|
  json.extract! attribute_descriptor, :id, :create, :show, :index, :update, :delete
  json.url attribute_descriptor_url(attribute_descriptor, format: :json)
end
