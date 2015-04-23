angular.module('simapp').factory('Geometry', (DataCache,ModelFactory,ObjectFactory,$http) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (geometry) ->
    # Add the standard object methods
    ObjectFactory("geometries", geometry, [{belongs_to: "geometry_type"}
                                           {belongs_to: "project"}
                                           {has_many: "assigned_geometries"}
                                           {has_many: "simulations", through: "assigned_geometries"}
                                           {has_many: "reports", as: "reportable"}])

    # Add the custom object methods
    geometry.refreshStatus = ->
      $http.get("geometry/#{geometry.id}")
        .success (data) ->
          DataCache.geometries[geometry.id].status = data.geometry.status
          DataCache.geometries[geometry.id].results = data.geometry.results

    geometry.after_failed_delete.push (data) ->
      if data.message and data.message.simulations
        angular.forEach data.message.simulations, (message) ->
          alert(message)

    geometry.after_failed_save.push (data) ->
      complete_message = "Could not save geometry\n"
      angular.forEach data.message, (message_type) ->
        angular.forEach message_type, (message) ->
          complete_message += message + "\n"
      alert(complete_message)

    geometry.attributes = ->
      DataCache.geometry_types_overview[this.geo_type].attributes

  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("geometries", addMethods)

  # create the custom model methods
  modelMethods["geo_types"] = ->
    DataCache.geometry_types_overview

  # Create the promises for loading data
  modelMethods["geometry_types_overview_promise"] = $http.get('geometry_types_overview')
    .success (data) ->
      DataCache.geometry_types_overview = data
    .error (data) ->
      console.log('error loading geometry types overview')

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
