angular.module('simapp').factory('ImageData', ($http,$q) ->
  {
    variableNames: (simIds) ->
      params = {
        simulation_ids: simIds
      }
      return $q( (resolve, reject) ->
        $http.get("simulations/variable_names", params: params)
          .success (data) ->
            resolve(data.variable_names)
      )
    componentDirections: (simIds, variableName) ->
      params = {
        simulation_ids: simIds
        variable_name: variableName
      }
      return $q( (resolve, reject) ->
        $http.get("simulations/component_directions", params: params)
          .success (data) ->
            resolve(data.component_directions)
      )
    views: (simIds, variableName, componentDirection) ->
      params = {
        simulation_ids: simIds
        variable_name: variableName
        component_direction: componentDirection
      }
      return $q( (resolve, reject) ->
        $http.get("simulations/views", params: params)
          .success (data) ->
            resolve(data.views)
      )
  }
)
