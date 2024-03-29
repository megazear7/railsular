angular.module('simapp').factory('Result', (DataCache,ModelFactory,ObjectFactory,$http) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (result) ->
    # Add the standard object methods
    ObjectFactory("results", result, [{has_and_belongs_to_many: "simulations"}])

    # Add the custom object methods
    # None

  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("results", addMethods)

  # create the custom model methods
  # None

  # Create the promises for loading data
  modelMethods["promise"] = $http.get('results')
    .success (data) ->
      angular.forEach data.results, (result) ->
        DataCache.results[result.id] = result
        DataCache.results[result.id].editing = false
      angular.forEach DataCache.results, (result, proj_id) ->
        addMethods(result)
    .error (data) ->
      console.log('error loading results')

  modelMethods["results_simulations_promise"] = $http.get('results_simulations')
    .success (data) ->
      angular.forEach data.result_simulations, (join) ->
        DataCache.results_simulations.push(join)
    .error (data) ->
      console.log('error loading results_simulations join data')


  # Return the model methods
  modelMethods
)
.run()
