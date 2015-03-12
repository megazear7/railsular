json.set! :attribute_descriptor do
  json.extract! @attribute_descriptor, *([:id, :name, :attr_type, :display, :validation, :usage, :geometry_type_id])
end
json.set! :message, @message
