angular.module('receta').factory('Simulation', (DataCache) ->
  addMethods = (simulation) ->

    simulation.save = ->
      # todo use $http to save to rails API
      console.log("not yet implemented")

    simulation.startEdit = ->
      this.editing = true

    simulation.stopEdit = ->
      simulation.save()
      this.editing = false

    simulation.geometries = ->
      geoIds = []
      angular.forEach(DataCache.geometries_simulations, (val) ->
        if val.simulation_id == simulation.id
          geoIds.push(val.geometry_id)
      )
      geoList = {}
      angular.forEach(geoIds, (geo_id) ->
        geoList[geo_id] = DataCache.geometries[geo_id]
      )
      geoList

    simulation.geometry = (id) ->
      geos = simulation.geometries()
      if geos[id]
        geos[id]
      else
        "Simulation with id #{simulation.id} does not have a geometry with id #{id}"

    simulation.project = ->
      DataCache.projects[simulation.project_id]

  angular.forEach(DataCache.simulations, (simulation, sim_id) ->
    addMethods(simulation)
  )

  {
    all: ->
      DataCache.simulations
    find: (id) ->
      DataCache.simulations[id]
    create: (sim) ->
      # todo use $http to save to rails API
      sim.id = 20
      DataCache.simulations[sim.id] = sim
      addMethods(sim)
      DataCache.simulations[sim.id]
  }
)