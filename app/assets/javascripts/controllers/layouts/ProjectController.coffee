controllers = angular.module('controllers')
controllers.controller("ProjectController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result', '$http', 'Report'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry,Result,$http,Report)->
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

    $scope.showReport = false

    $scope.openReport = ->
      $scope.showReport = true

    $scope.closeReport = ->
      $scope.showReport = false

    $scope.sendReport = (reportMessage) ->
      $scope.showReport = false
      $http.get("project/#{$scope.activeProject.id}/report", params: {message: reportMessage})
        .success ->
          alert("Report sent")
        .error ->
          alert("Error sending report")
])
