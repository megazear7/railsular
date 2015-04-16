angular.module('simapp').factory('ResultData', ($http,$q) ->
  {
    variableNames: (simIds) ->
      params = {
        simulation_ids: simIds
      }
      return $q( (resolve, reject) ->
        $http.get("simulations/curve_variable_names", params: params)
          .success (data) ->
            resolve(data.variable_names)
      )
  }
)
