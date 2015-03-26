controllers = angular.module('controllers')
controllers.controller("ResultController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry,Result)->
    $scope.template = { url: "modules/result.html" }

    $scope.simulations = $scope.activeProject.simulations_where(status: "Complete")

    console.log($scope.simulations)
    #console.log($scope.result.add_simulation(Simulation.find(40)))
])
