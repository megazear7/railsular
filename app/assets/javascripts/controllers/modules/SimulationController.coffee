controllers = angular.module('controllers')
controllers.controller("SimulationController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/simulation.html" }

    $scope.run = ->
      alert("run")

    $scope.duplicate = ->
      promise = Simulation.create(
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
      promise.then (sim) ->
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
      angular.forEach($scope.simulation.assigned_geos(), (assigned_geometry, id) ->
        assigned_geometry.startEdit()
      )

    $scope.stopEdit = ->
      $scope.simulation.stopEdit()
      angular.forEach($scope.simulation.geometries(), (geometry, geo_id) ->
        geometry.stopEdit()
      )
      angular.forEach($scope.simulation.assigned_geos(), (assigned_geometry, id) ->
        assigned_geometry.stopEdit()
      )
])
