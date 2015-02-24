controllers = angular.module('controllers')
controllers.controller("ProjectController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry',
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/project.html" }

    $scope.projects = Project.all()
    $scope.activeProject = $scope.projects[$routeParams.project_id]

    $scope.simulations = $scope.activeProject.simulations()
    $scope.geometries = $scope.activeProject.geometries()

    $scope.displaySimNav = $location.path().indexOf("simulations") > -1
    $scope.displayGeoNav = $location.path().indexOf("geometries") > -1
    if $scope.displaySimNav == $scope.displayGeoNav
      $scope.displaySimNav = true
      $scope.displayGeoNav = false

    $scope.delete = ->
      $scope.activeProject.delete()
      $location.path("projects/")

    $scope.report = ->
      alert("Reporting project...")
])
