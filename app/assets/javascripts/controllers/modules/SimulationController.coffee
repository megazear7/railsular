controllers = angular.module('controllers')
controllers.controller("SimulationController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/simulation.html" }

    $scope.geometry_types = Geometry.types()

    $scope.run = ->
      alert("run")

    $scope.duplicate = ->
      sim = Simulation.create(
        {
          name: $scope.simulation.name
          description: $scope.simulation.description
          editing: true
          project_id: $scope.simulation.project_id
          status: $scope.simulation.status
          measurement_scale: $scope.simulation.measurement_scale
          fluid_type: $scope.simulation.fluid_type
          kinematic_viscosity: $scope.simulation.kinematic_viscosity
          density: $scope.simulation.density
          steps: $scope.simulation.steps
        }
      )
      $location.path("projects/"+$scope.activeProject.id+"/simulations/"+sim.id)

    $scope.delete = ->
      $scope.simulation.delete()
      $location.path("projects/"+$scope.activeProject.id+"/simulations/")

    $scope.report = ->
      alert("Reporting Simulation...")

    $scope.startEdit = ->
      $scope.simulation.startEdit()
      angular.forEach($scope.simulation.geometries(), (geometry, geo_id) ->
        geometry.startEdit()
      )

    $scope.stopEdit = ->
      $scope.simulation.stopEdit()
      angular.forEach($scope.simulation.geometries(), (geometry, geo_id) ->
        geometry.stopEdit()
      )

    $scope.addGeometry = (type) ->
      if type == 'inlet'
        $scope.addInlet()
      else if type == 'outlet'
        $scope.addOutlet()

    $scope.addInlet = ->
      geo = Geometry.create(
        {
          name: "Name"
          description: "Description"
          editing: true
          project_id: $scope.activeProject.id
          type: "inlet",
          attributes: {vx: 0, vy: 0, vz: 0}
        }
      )
      $scope.simulation.addGeometry(geo.id)
      $location.path("projects/"+$scope.activeProject.id+"/geometries/"+geo.id)

    $scope.addOutlet = ->
      geo = Geometry.create(
        {
          name: "Name"
          description: "Description"
          editing: true
          project_id: $scope.activeProject.id
          simulation_id: $scope.simulation.id
          type: "outlet",
          attributes: {}
        }
      )
      $location.path("projects/"+$scope.activeProject.id+"/geometries/"+geo.id)
])
