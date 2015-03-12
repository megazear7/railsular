angular.module('receta').factory('GeometryType', (AdminDataCache,$http,ModelFactory,ObjectFactory) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (geometry_type) ->
    # Add the standard object methods
    ObjectFactory("geometry_types", geometry_type, [{has_many: "attribute_descriptor"}])

    # Add the custom object methods
    # None

  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("geometry_types", addMethods)

  # create the custom model methods
  # None

  # Create the promises for loading data
  modelMethods["promise"] = $http.get('/admin/geometry_types')
    .success (data, status, headers, config) ->
      angular.forEach data.geometry_types, (geometry_type) ->
        AdminDataCache.geometry_types[geometry_type.id] = geometry_type
        AdminDataCache.geometry_types[geometry_type.id].editing = false
      angular.forEach AdminDataCache.geometry_types, (geometry_type, geometry_type_id) ->
        addMethods(geometry_type)
    .error (data, status, headers, config) ->
      console.log('error loading geometry types')

  # Return the model methods
  modelMethods
)
.run( (AssignedGeometry) -> console.log('Geometry Type service is ready') )
