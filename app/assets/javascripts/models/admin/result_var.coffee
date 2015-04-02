angular.module('simapp').factory('ResultVar', (DataCache,$http,ModelFactory,ObjectFactory) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (result_var) ->
    # Add the standard object methods
    ObjectFactory("result_vars", result_var, [{belongs_to: "app"}], "admin/")

    # Add the custom object methods
    # None

  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("result_vars", addMethods, "admin/")

  # create the custom model methods
  # None

  # Create the promises for loading data
  modelMethods["promise"] = $http.get('admin/result_vars')
    .success (data) ->
      angular.forEach data.result_vars, (result_var) ->
        DataCache.result_vars[result_var.id] = result_var
        DataCache.result_vars[result_var.id].editing = false
      angular.forEach DataCache.result_vars, (result_var, result_var_id) ->
        addMethods(result_var)
    .error (data) ->
      console.log('error loading result_vars')

  # Return the model methods
  modelMethods
)
.run()
