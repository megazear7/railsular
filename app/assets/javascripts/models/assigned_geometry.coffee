angular.module('receta').factory('AssignedGeometry', (DataCache,ModelFactory,$http) ->
  addMethods = (assigned_geometry) ->

    assigned_geometry.save = ->
      # todo if there is an error saving the assigned_geometry then revert the assigned_geometry to what the api returns
      $http.post("/assigned_geometry/#{assigned_geometry.id}/update", assigned_geometry)

    assigned_geometry.delete = ->
      # todo, if it comes back that there was an error trying to delete the asssigned_geometry then add the asssigned_geometry back
      $http.delete("/assigned_geometry/#{assigned_geometry.id}/delete")
      delete DataCache.assigned_geometries[assigned_geometry.id]

    assigned_geometry.startEdit = ->
      this.editing = true

    assigned_geometry.stopEdit = ->
      assigned_geometry.save()
      this.editing = false

    assigned_geometry.geometry = ->
      DataCache.geometries[this.geometry_id]

    assigned_geometry.simulation = ->
      DataCache.simulations[this.simulation_id]

    assigned_geometry.attributes = ->
      DataCache.geometry_types[this.geometry().geo_type].assigned_attributes


  promise = $http.get('/assigned_geometries')
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

  modelMethods = ModelFactory("assigned_geometries", addMethods)

  modelMethods["promise"] = promise

  modelMethods
)
.run( (AssignedGeometry) -> console.log('Assigned Geometry service is ready') )
