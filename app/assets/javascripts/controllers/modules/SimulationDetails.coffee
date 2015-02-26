controllers = angular.module('controllers')
controllers.controller("SimulationDetailsController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/simulation_details.html" }
])
