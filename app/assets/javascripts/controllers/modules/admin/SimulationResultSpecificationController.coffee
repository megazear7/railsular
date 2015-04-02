controllers = angular.module('controllers')
controllers.controller("SimulationResultSpecificationController", [ '$scope', '$routeParams', '$location', '$resource', 'JobDescriptor'
  ($scope,$routeParams,$location,$resource,JobDescriptor)->
    $scope.template = { url: "modules/admin/simulation_result_specification.html" }

    $scope.variables = { }

    $scope.variables[1] = {
      name: "abc"
      id: 1
      editing: false
    }
    $scope.variables[1].startEdit = ->
      $scope.variables[1].editing = true
    $scope.variables[1].stopEdit = ->
      $scope.variables[1].editing = false

    $scope.create = ->
      $scope.variables[2] = {
        id: 2
        name: ""
        editing: true
      }
      $scope.variables[2].startEdit = ->
        $scope.variables[2].editing = true
      $scope.variables[2].stopEdit = ->
        $scope.variables[2].editing = false

    $scope.delete = (variable) ->
      delete $scope.variables[variable.id]
])
