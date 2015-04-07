angular.module('simapp').factory('ImageData', ($http,$q) ->
  {
    variableNames: ->
      ["NormalisedUw", "b", "c"]
    componentDirections: (variableName) ->
      if variableName == "NormalisedUw"
        ["Mag", "y", "z"]
      else
        ["blah", "test", "again"]
    views: (variableName, componentDirection) ->
      if variableName == "NormalisedUw" and componentDirection = "Mag"
        ["plot_all_to_mesh_bottom", "plot_all_to_mesh_bottom_front_left", "plot_all_to_mesh_bottom_front_right"]
      else
        ["abc", "def", "ghi"]
  }
)
