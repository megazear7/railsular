controllers = angular.module('controllers')
controllers.controller("SimulationsController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.title = "Simulations"
    $scope.message = "Hello this is the simulations controller"
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.activeProject = { id: $routeParams.project_id }

    $scope.simulations =
      {
        1: { name: "test sim", description: "my test description", id: 1, status: "Queued" },
        2: { name: "another test", description: "my test description", id: 2, status: "Queued" },
        5: { name: "My SimulationA", description: "my test description", id: 5, status: "Queued" },
        6: { name: "Sim BBB", description: "my test description", id: 6, status: "Queued" }
      }

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
