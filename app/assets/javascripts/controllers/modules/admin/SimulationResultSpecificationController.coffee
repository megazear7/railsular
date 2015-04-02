controllers = angular.module('controllers')
controllers.controller("SimulationResultSpecificationController", [ '$scope', '$routeParams', '$location', '$resource', 'JobDescriptor', 'ResultVar'
  ($scope,$routeParams,$location,$resource,JobDescriptor,ResultVar)->
    $scope.template = { url: "modules/admin/simulation_result_specification.html" }

    $scope.result_vars = $scope.app.result_vars()

    $scope.delete = (result_var) ->
      result_var.delete()
      $scope.result_vars = $scope.app.result_vars()

    $scope.create = ->
      ResultVar.create({name: "", app_id: $scope.app.id})
        .then (result_var) ->
          $scope.result_vars = $scope.app.result_vars()
          result_var.startEdit()
])
