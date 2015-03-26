controllers = angular.module('controllers')
controllers.controller("SimulationSpecificationController", [ '$scope', '$routeParams', '$location', '$resource', 'AttributeDescriptor', 'AttributeDescriptorValue', 'App'
  ($scope,$routeParams,$location,$resource,AttributeDescriptor,AttributeDescriptorValue,App)->
    $scope.template = { url: "modules/admin/simulation_specification.html" }

    $scope.app = App.find(1)

    $scope.setIterative = (bool) ->
      $scope.app.iterative = bool
      $scope.app.save()
])
