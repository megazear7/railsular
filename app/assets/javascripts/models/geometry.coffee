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

    geometry.addSimulation = (sim_id) ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      DataCache.geometries_simulations["#{geometry.id}_#{sim_id}"] = {simulation_id: sim_id, geometry_id: geometry.id}

    geometry.specificAttributes = (sim_id) ->
      DataCache.geometries_simulations["#{geometry.id}_#{sim_id}"].attributes

    geometry.simulations = ->
      simIds = []
      angular.forEach(DataCache.geometries_simulations, (val, key) ->
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
    find: (id) ->
      DataCache.geometries[id]
    create: (geo) ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      geo.id = 20
      DataCache.geometries[geo.id] = geo
      addMethods(geo)
      DataCache.geometries[geo.id]
    types: ->
      DataCache.geometry_types
  }
)
.run( (Geometry) -> console.log('Geometry service is ready') )
