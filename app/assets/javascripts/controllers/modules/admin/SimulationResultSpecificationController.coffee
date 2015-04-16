controllers = angular.module('controllers')
controllers.controller("SimulationResultSpecificationController", [ '$scope', '$routeParams', '$location', '$resource', 'JobDescriptor'
  ($scope,$routeParams,$location,$resource,JobDescriptor)->
    $scope.template = { url: "modules/admin/simulation_result_specification.html" }
])
