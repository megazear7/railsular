angular.module('receta').factory('AssignedGeometry', (DataCache,ModelFactory,ObjectFactory,$http) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (assigned_geometry) ->
    # Add the standard object methods
    ObjectFactory("assigned_geometries", assigned_geometry)

    # Add the custom object methods
    assigned_geometry.geometry = ->
      DataCache.geometries[this.geometry_id]

    assigned_geometry.simulation = ->
      DataCache.simulations[this.simulation_id]

    assigned_geometry.attributes = ->
      DataCache.geometry_types[this.geometry().geo_type].assigned_attributes


  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("assigned_geometries", addMethods)

  # create the custom model methods
  # None

  # Create the promises for loading data
  modelMethods["promise"] = $http.get('/assigned_geometries')
    .success (data, status, headers, config) ->
      angular.forEach(data.assigned_geometries, (assigned_geo) ->
        DataCache.assigned_geometries[assigned_geo.id] = assigned_geo
        DataCache.assigned_geometries[assigned_geo.id].editing = false
      )
      angular.forEach(DataCache.assigned_geometries, (assigned_geometry, assigned_geo_id) ->
        addMethods(assigned_geometry)
      )
    .error (data, status, headers, config) ->
      console.log('error loading assigned_geos')

  # Return the model methods
  modelMethods
)
.run( (AssignedGeometry) -> console.log('Assigned Geometry service is ready') )
