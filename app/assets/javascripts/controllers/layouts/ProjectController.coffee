controllers = angular.module('controllers')
controllers.controller("ProjectController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry,Result)->
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.projects = Project.all()
    $scope.activeProject = Project.find($routeParams.project_id)
    $scope.simulations = $scope.activeProject.simulations()
    $scope.geometries = $scope.activeProject.geometries()
    $scope.results = Result.all()
 
    $scope.displaySimNav = $location.path().indexOf("simulations") > -1
    $scope.displayGeoNav = $location.path().indexOf("geometries") > -1
    $scope.displayResNav = $location.path().indexOf("results") > -1

    if not $scope.displaySimNav && not $scope.displayGeoNav && not $scope.displayResNav
      $scope.displaySimNav = true

    $scope.delete = ->
      $scope.activeProject.delete()
      $location.path("projects/")

    $scope.report = ->
      alert("Reporting project...")
])
