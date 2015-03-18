json.set! :attribute_descriptor_value do
  json.extract! @attribute_descriptor_value, *([:id, :value, :attribute_descriptor_id])
end
