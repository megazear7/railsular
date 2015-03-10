angular.module('receta').factory('Simulation', (DataCache,AssignedGeometry,ModelFactory,ObjectFactory,$http) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (simulation) ->
    # Add the standard object methods
    ObjectFactory("simulations", simulation)

    # Add the custom object methods
    simulation.assigned_geos = ->
      assigned_geos = {}
      angular.forEach(DataCache.assigned_geometries, (assigned_geo, id) ->
        if assigned_geo.simulation_id == simulation.id
          assigned_geos[id] = assigned_geo
      )
      assigned_geos
 
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

    # TODO this should be deleted, you can just do simulation.geometries[id] instead
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
      angular.forEach(attrs, (attr_val, attr_name) ->
        assigned_geo[attr_name] = attr_val
      )
      AssignedGeometry.create(assigned_geo)

    simulation.project = ->
      DataCache.projects[simulation.project_id]

  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("simulations", addMethods)

  # create the custom model methods
  modelMethods["attributes"] = ->
    DataCache.simulation_attributes

  # Create the promises for loading data
  modelMethods["promise"] = $http.get('/simulations')
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

  modelMethods["simulation_attributes_promise"] = $http.get('/simulations/attributes')
    .success (data, status, headers, config) ->
      DataCache.simulation_attributes = data.attributes
    .error (data, status, headers, config) ->
      console.log("error loading simulation attributes")

  # Return the model methods
  modelMethods
)
.run( (Simulation) -> console.log('Simulation service is ready') )
