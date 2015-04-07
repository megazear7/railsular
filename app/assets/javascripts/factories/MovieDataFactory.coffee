angular.module('simapp').factory('MovieData', ($http,$q) ->
  {
    sliceNormals: (simIds) ->
      params = {
        simulation_ids: simIds
      }
      return $q( (resolve, reject) ->
        $http.get("simulations/movie_slice_normals", params: params)
          .success (data) ->
            resolve(data.slice_normals)
      )
    variableNames: (simIds, sliceNormal) ->
      params = {
        simulation_ids: simIds
        slice_normal: sliceNormal
      }
      return $q( (resolve, reject) ->
        $http.get("simulations/movie_variable_names", params: params)
          .success (data) ->
            resolve(data.variable_names)
      )
    componentDirections: (simIds, sliceNormal, variableName) ->
      params = {
        simulation_ids: simIds
        slice_normal: sliceNormal
        variable_name: variableName
      }
      return $q( (resolve, reject) ->
        $http.get("simulations/movie_component_directions", params: params)
          .success (data) ->
            resolve(data.component_directions)
      )
    frameCount: (simIds, sliceNormal, variableName, componentDirection) ->
      params = {
        simulation_ids: simIds
        slice_normal: sliceNormal
        variable_name: variableName
        component_direction: componentDirection
      }
      return $q( (resolve, reject) ->
        $http.get("simulations/frame_count", params: params)
          .success (data) ->
            resolve(data.frame_count)
      )
  }
)
