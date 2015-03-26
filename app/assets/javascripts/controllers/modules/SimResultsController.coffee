controllers = angular.module('controllers')
controllers.controller("SimResultsController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry,Result)->
    $scope.template = { url: "modules/sim_results.html" }

    $scope.standardResults = Result.where(standard: true)
    $scope.customResults = $scope.simulation.results()
])
