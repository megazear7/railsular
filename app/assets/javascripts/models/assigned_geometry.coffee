angular.module('receta').factory('AssignedGeometry', (DataCache, ModelFactory) ->
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

  angular.forEach(DataCache.assigned_geometries, (assigned_geometry, assigned_geo_id) ->
    addMethods(assigned_geometry)
  )

  ModelFactory("assigned_geometries", addMethods)
)
.run( (AssignedGeometry) -> console.log('Transient Geometry service is ready') )
