controllers = angular.module('controllers')
controllers.controller("SimulationSpecificationController", [ '$scope', '$routeParams', '$location', '$resource', 'AttributeDescriptor', 'AttributeDescriptorValue'
  ($scope,$routeParams,$location,$resource,AttributeDescriptor,AttributeDescriptorValue)->
    $scope.template = { url: "modules/admin/simulation_specification.html" }
])
