angular.module('receta').factory('AssignedGeometry', (DataCache) ->
  addMethods = (assigned_geometry) ->

    assigned_geometry.save = ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      console.log("not yet implemented")

    assigned_geometry.delete = ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      delete DataCache.geometries[assigned_geometry.id]

    assigned_geometry.startEdit = ->
      this.editing = true

    assigned_geometry.stopEdit = ->
      assigned_geometry.save()
      this.editing = false

  angular.forEach(DataCache.geometries, (assigned_geometry, geo_id) ->
    addMethods(assigned_geometry)
  )

  {
    all: ->
      DataCache.assigned_geometries
    find: (id) ->
      DataCache.assigned_geometries[id]
    create: (trans_geo) ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      trans_geo.id = 20
      DataCache.assigned_geometries[trans_geo.id] = trans_geo
      addMethods(trans_geo)
      DataCache.assigned_geometries[trans_geo.id]
  }
)
.run( (AssignedGeometry) -> console.log('Transient Geometry service is ready') )
