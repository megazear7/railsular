angular.module('simapp').factory('Geometry', (DataCache,ModelFactory,ObjectFactory,$http) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (geometry) ->
    # Add the standard object methods
    ObjectFactory("geometries", geometry, [{belongs_to: "geometry_type"},{belongs_to: "project"}, {has_many: "assigned_geometries"}, {has_many_through: {has_many: "simulations", through: "assigned_geometries"}}])

    # Add the custom object methods
    geometry.refreshStatus = ->
      $http.get("geometry/#{geometry.id}")
        .success (data) ->
          DataCache.geometries[geometry.id].status = data.geometry.status

    geometry.attributes = ->
      DataCache.geometry_types[this.geo_type].attributes

  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("geometries", addMethods)

  # create the custom model methods
  modelMethods["geo_types"] = ->
    DataCache.geometry_types

  # Create the promises for loading data
  modelMethods["geometry_type_promise"] = $http.get('geometry_types')
    .success (data) ->
      DataCache.geometry_types = data
    .error (data) ->
      console.log('error loading geometry types')

  modelMethods["promise"] = $http.get('geometries')
    .success (data) ->
      angular.forEach data.geometries, (geometry) ->
        DataCache.geometries[geometry.id] = geometry
        DataCache.geometries[geometry.id].editing = false
      angular.forEach DataCache.geometries, (geometry, geo_id) ->
        addMethods(geometry)
    .error (data) ->
      console.log('error loading geometries')

  # Return the model methods
  modelMethods
)
.run()
