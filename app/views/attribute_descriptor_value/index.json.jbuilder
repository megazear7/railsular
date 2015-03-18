json.set! :attribute_descriptor_values do
  json.array! @attribute_descriptor_values do |attribute_descriptor_value|
    json.extract! attribute_descriptor_value, *([:id, :value, :attribute_descriptor_id])
  end
end
