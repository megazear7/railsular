controllers = angular.module('controllers')
controllers.controller("SimulationResultsController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry)->
    $scope.template = { url: "modules/result.html" }

    #$scope.result = $scope.simulation.result()
])
