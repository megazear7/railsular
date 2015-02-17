controllers = angular.module('controllers')
controllers.controller("SimulationsController", [ '$scope', '$routeParams', '$location', '$resource', 'ProjectService',
  ($scope,$routeParams,$location,$resource,ProjectService)->
    $scope.title = "Simulations"
    $scope.message = "Hello this is the simulations controller"
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.activeProject = ProjectService[$routeParams.project_id]

    $scope.simulations = $scope.activeProject.simulations

    if $routeParams.simulation_id
      $scope.simulation = $scope.simulations[$routeParams.simulation_id]
      $scope.simSelected = { selected: true, message: "Sim already selected" }
    else
      $scope.simSelected = { selected: false, message: "Select a simulation on the left" }

    # $routeParams.project_id must be set. Display the simulation tree for the given project on the left and 
    # project details on the right. If a simulation is selected display its details on the right instead of project
    # details. If the root project node is selected display the project details again. If the geometries tab above the 
    # tree is selected then navigate to /projects/:project_id/geometries
])
