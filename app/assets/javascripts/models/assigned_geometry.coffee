angular.module('receta').factory('AssignedGeometry', (DataCache,ModelFactory,$http) ->
  addMethods = (assigned_geometry) ->

    assigned_geometry.save = ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      console.log("not yet implemented")

    assigned_geometry.delete = ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
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


  $http.get('/assigned_geos')
    .success (data, status, headers, config) ->
      angular.forEach(data.assigned_geos, (assigned_geo) ->
        DataCache.assigned_geometries[assigned_geo.id] = assigned_geo
        DataCache.assigned_geometries[assigned_geo.id].editing = false
      )
      angular.forEach(DataCache.assigned_geometries, (assigned_geometry, assigned_geo_id) ->
        addMethods(assigned_geometry)
      )
    .error (data, status, headers, config) ->
      console.log('error loading assigned_geos')
 

  ModelFactory("assigned_geometries", addMethods)
)
.run( (AssignedGeometry) -> console.log('Assigned Geometry service is ready') )
