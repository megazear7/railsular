angular.module('receta').factory('Simulation', (DataCache,AssignedGeometry,ModelFactory) ->
  addMethods = (simulation) ->

    simulation.save = ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      console.log("not yet implemented")

    simulation.delete = ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      delete DataCache.simulations[simulation.id]

    simulation.startEdit = ->
      this.editing = true

    simulation.stopEdit = ->
      simulation.save()
      this.editing = false

    simulation.geometries = ->
      geoIds = []
      angular.forEach(DataCache.assigned_geometries, (val, key) ->
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

    simulation.addGeometry = (geo_id, attr) ->
      AssignedGeometry.create({simulation_id: simulation.id, geometry_id: geo_id, attributes: attr})

    simulation.project = ->
      DataCache.projects[simulation.project_id]

  angular.forEach(DataCache.simulations, (simulation, sim_id) ->
    addMethods(simulation)
  )

  ModelFactory("simulations", addMethods)
)
.run( (Simulation) -> console.log('Simulation service is ready') )
