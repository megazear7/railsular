angular.module('simapp').factory('AttributeDescriptor', (AdminDataCache,$http,ModelFactory,ObjectFactory) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (attribute_descriptor) ->
    # Add the standard object methods
    ObjectFactory("attribute_descriptors", attribute_descriptor, [{belongs_to: "geometry_type"}, {has_many: "attribute_descriptor_values"}], AdminDataCache, "admin/")

    # Add the custom object methods
    # None

  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("attribute_descriptors", addMethods, AdminDataCache, "admin/")

  # create the custom model methods
  modelMethods.simulation_attribute_descriptors = ->
    ret = {}
    angular.forEach AdminDataCache.attribute_descriptors, (attr_desc, id) ->
      if attr_desc.usage == "simulation"
        ret[attr_desc.id] = attr_desc
    ret

  # Create the promises for loading data
  modelMethods["promise"] = $http.get('admin/attribute_descriptors')
    .success (data, status, headers, config) ->
      angular.forEach data.attribute_descriptors, (attribute_descriptor) ->
        AdminDataCache.attribute_descriptors[attribute_descriptor.id] = attribute_descriptor
        AdminDataCache.attribute_descriptors[attribute_descriptor.id].editing = false
      angular.forEach AdminDataCache.attribute_descriptors, (attribute_descriptor, attribute_descriptor_id) ->
        addMethods(attribute_descriptor)
    .error (data, status, headers, config) ->
      console.log('error loading attribute descriptors')

  # Return the model methods
  modelMethods
)
.run()
