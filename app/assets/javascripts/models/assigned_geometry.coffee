angular.module('receta').factory('AssignedGeometry', (DataCache) ->
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

  {
    all: ->
      DataCache.assigned_geometries
    find: (id) ->
      DataCache.assigned_geometries[id]
    find_by: (attrs) ->
      assigned_geometry = false
      angular.forEach(DataCache.assigned_geometries, (assigned_geo, assigned_geo_id) ->
        isFound = true
        angular.forEach(attrs, (val, attr) ->
          if assigned_geo[attr] != val
            isFound = false
        )
        if isFound
          assigned_geometry = assigned_geo
      )
      if assigned_geometry
        return assigned_geometry
      else
        return false

    create: (assigned_geo) ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      assigned_geo.id = Math.floor((Math.random()*100000)+1)
      DataCache.assigned_geometries[assigned_geo.id] = assigned_geo
      addMethods(assigned_geo)
      DataCache.assigned_geometries[assigned_geo.id]
  }
)
.run( (AssignedGeometry) -> console.log('Transient Geometry service is ready') )
