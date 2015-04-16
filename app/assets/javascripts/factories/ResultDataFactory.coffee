angular.module('simapp').factory('ResultData', ($http,$q) ->
  {
    variableNames: (simIds) ->
      params = {
        simulation_ids: simIds
      }
      return $q( (resolve, reject) ->
        $http.get("simulations", params: params)
          .success (data) ->
            resolve(["F0 all", "F1 all"])
            #resolve(data.variable_names)
      )
  }
)
