angular.module('receta').factory('Geometry', (DataCache) ->
  addMethods = (geometry) ->
    geometry.save = ->
      # todo use $http to save to rails API
      console.log("not yet implemented")
    geometry.startEdit = ->
      this.editing = true
    geometry.stopEdit = ->
      geometry.save()
      this.editing = false
    geometry.simulation = ->
      DataCache["simulations"][geometry.simulation_id]
    geometry.project = ->
      DataCache["projects"][geometry.project_id]

  angular.forEach(DataCache["geometries"], (geometry, geo_id) ->
    addMethods(geometry)
  )

  {
    all: ->
      DataCache["geometries"]
    find: (id) ->
      DataCache["geometries"][id]
    create: (geo) ->
      # todo use $http to save to rails API
      geo.id = 20
      DataCache["geometries"][geo.id] = geo
      addMethods(geo)
      DataCache["geometries"][geo.id]
  }
)
