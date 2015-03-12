angular.module('receta').factory('AttributeDescriptorValue', (AdminDataCache,$http,ModelFactory,ObjectFactory) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (attribute_descriptor_value) ->
    # Add the standard object methods
    ObjectFactory("attribute_descriptor_values", attribute_descriptor_value, [{belongs_to: "attribute_descriptor"}], AdminDataCache, "/admin")

    # Add the custom object methods
    # None

  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("attribute_descriptor_values", addMethods, AdminDataCache, "/admin")

  # create the custom model methods
  # None

  # Create the promises for loading data
  modelMethods["promise"] = $http.get('/admin/attribute_descriptor_values')
    .success (data, status, headers, config) ->
      angular.forEach data.attribute_descriptor_values, (attribute_descriptor_value) ->
        AdminDataCache.attribute_descriptor_values[attribute_descriptor_value.id] = attribute_descriptor_value
        AdminDataCache.attribute_descriptor_values[attribute_descriptor_value.id].editing = false
      angular.forEach AdminDataCache.attribute_descriptor_values, (attribute_descriptor_value, attribute_descriptor_value_id) ->
        addMethods(attribute_descriptor_value)
    .error (data, status, headers, config) ->
      console.log('error loading attribute descriptors')

  # Return the model methods
  modelMethods
)
.run( (AttributeDescriptorValue) -> console.log('Attribute Descriptor Value service is ready') )
