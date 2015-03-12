json.array!(@attribute_descriptor_values) do |attribute_descriptor_value|
  json.extract! attribute_descriptor_value, :id, :create, :show, :index, :update, :delete
  json.url attribute_descriptor_value_url(attribute_descriptor_value, format: :json)
end
