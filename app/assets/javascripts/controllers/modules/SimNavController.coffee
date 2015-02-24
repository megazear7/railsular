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


    # the responsibility of this controller is to manage a list of simulations
    # This could be in a tree form or just a list form. it needs a link to
    # /projects/<current_project_id>/geometries. If a simulation is selected in
    # this controller is should affect the global selected simulation variable.
])
