controllers = angular.module('controllers')
controllers.controller("SimulationDetailsController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry)->
    $scope.template = { url: "modules/simulation_details.html" }

    $scope.attributes = Simulation.attributes()
])
