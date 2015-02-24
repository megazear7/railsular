controllers = angular.module('controllers')
controllers.controller("SimNavController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry',
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry)->
    $scope.title = "Sim Nav"
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/sim_nav.html" }

    $scope.addSimulation = ->
      sim = Simulation.create(
        {
          name: "Name"
          description: "Description"
          editing: true
          project_id: $scope.activeProject.id
          status: "New"
          measurement_scale: ""
          fluid_type: ""
          kinematic_viscosity: 0
          density: 0
          steps: 0
        }
      )
      $location.path("projects/"+$scope.activeProject.id+"/simulations/"+sim.id)
])
