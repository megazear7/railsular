json.set! :attribute_descriptors do
  json.array! @attribute_descriptors do |attribute_descriptor|
    json.extract! attribute_descriptor, *([:id, :name, :attr_type, :display, :validation, :usage, :geometry_type_id])
  end
end
