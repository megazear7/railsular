controllers = angular.module('controllers')
controllers.controller("SimulationController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry)->
    $scope.title = "Simulation"
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/simulation.html" }

    $scope.geometry_types = Geometry.types()

    $scope.run = ->
      alert("run")
    $scope.duplicate = ->
      alert("duplicate")
    $scope.delete = ->
      alert("delete")
    $scope.report = ->
      alert("report")

    $scope.add = (type) ->
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
          simulation_id: $scope.simulation.id
          type: "inlet",
          attributes: {vx: 0, vy: 0, vz: 0}
        }
      )
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
