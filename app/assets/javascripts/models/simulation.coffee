angular.module('receta').factory('Simulation', (DataCache,AssignedGeometry,ModelFactory,$http) ->
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

    simulation.addGeometry = (geo_id, attrs) ->
      assigned_geo = {
        simulation_id: simulation.id
        geometry_id: geo_id
      }
      console.log(attrs)
      angular.forEach(attrs, (attr_val, attr_name) ->
        assigned_geo[attr_name] = attr_val
      )
      console.log(DataCache)
      AssignedGeometry.create(assigned_geo)

    simulation.project = ->
      DataCache.projects[simulation.project_id]

  $http.get('/simulations')
    .success (data, status, headers, config) ->
      angular.forEach(data.simulations, (simulation) ->
        DataCache.simulations[simulation.id] = simulation
        DataCache.simulations[simulation.id].editing = false
      )
      angular.forEach(DataCache.simulations, (simulation, sim_id) ->
        addMethods(simulation)
      )
    .error (data, status, headers, config) ->
      console.log('error loading simulations')


  ModelFactory("simulations", addMethods)
)
.run( (Simulation) -> console.log('Simulation service is ready') )
