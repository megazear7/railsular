angular.module('receta').factory('Simulation', (DataCache,AssignedGeometry,ModelFactory,ObjectFactory,$http) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (simulation) ->
    # Add the standard object methods
    ObjectFactory("simulations", simulation, [{belongs_to: "project"}, {has_many: "assigned_geometries"}, {has_many_through: {has_many: "geometries", through: "assigned_geometries"}}])

    # Add the custom object methods
    simulation.addGeometry = (geo_id, attrs) ->
      assigned_geo = {
        simulation_id: simulation.id
        geometry_id: geo_id
      }
      angular.forEach(attrs, (attr_val, attr_name) ->
        assigned_geo[attr_name] = attr_val
      )
      AssignedGeometry.create(assigned_geo)

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
