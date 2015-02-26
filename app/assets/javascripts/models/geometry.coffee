angular.module('receta').factory('Geometry', (DataCache) ->
  addMethods = (geometry) ->

    geometry.save = ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      console.log("not yet implemented")

    geometry.delete = ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      delete DataCache.geometries[geometry.id]

    geometry.startEdit = ->
      this.editing = true

    geometry.stopEdit = ->
      geometry.save()
      this.editing = false

    geometry.addSimulation = (sim_id, attr) ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      new_id = Math.floor((Math.random() * 10000) + 1)
      DataCache.assigned_geometries[new_id] = {id: new_id, simulation_id: sim_id, geometry_id: geometry.id, attributes: attr}

    geometry.specificAttributes = (sim_id) ->
      attrs = { }
      angular.forEach(DataCache.assigned_geometries, (val, key) ->
        if val.geometry_id == geometry.id && val.simulation_id == sim_id
          attrs = val.attributes
      )
      attrs

    geometry.simulations = ->
      simIds = []
      angular.forEach(DataCache.assigned_geometries, (val, key) ->
        if val.geometry_id == geometry.id
          simIds.push(val.simulation_id)
      )
      simList = {}
      angular.forEach(simIds, (sim_id) ->
        simList[sim_id] = DataCache.simulations[sim_id]
      )
      simList

    geometry.project = ->
      DataCache.projects[geometry.project_id]

  angular.forEach(DataCache.geometries, (geometry, geo_id) ->
    addMethods(geometry)
  )

  {
    all: ->
      DataCache.geometries
    allByType: (type) ->
      geoList = {}
      angular.forEach(DataCache.geometries, (val, id) ->
        if val.type == type
          geoList[id] = val
      )
      geoList
    find: (id) ->
      DataCache.geometries[id]
    create: (geo) ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      geo.id = Math.floor((Math.random()*100000)+1)
      DataCache.geometries[geo.id] = geo
      addMethods(geo)
      DataCache.geometries[geo.id]
    types: ->
      DataCache.geometry_types
  }
)
.run( (Geometry) -> console.log('Geometry service is ready') )
