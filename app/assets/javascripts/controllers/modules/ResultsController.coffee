controllers = angular.module('controllers')
controllers.controller("ResultsController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry,Result)->
    $scope.template = { url: "modules/results.html" }

    $scope.standrdResults = Result.where(standard: true)
    $scope.customResults = $scope.simulation.results()
])
