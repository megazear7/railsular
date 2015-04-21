controllers = angular.module('controllers')
controllers.controller("GeometryController", [ '$scope', '$routeParams', '$location', '$resource', '$http', '$interval', 'Report'
  ($scope,$routeParams,$location,$resource,$http,$interval,Report)->
    $scope.template = { url: "modules/geometry.html" }

    refreshPromise = $interval(
      ->
        $scope.geometry.refreshStatus()
      30000
    )

    $scope.$on '$destroy', ->
      if (refreshPromise)
        $interval.cancel(refreshPromise)

    $scope.action = "/geometry/#{$scope.geometry.id}/update_file"

    $scope.delete = ->
      $scope.geometry.delete()
      $location.path("projects/"+$scope.activeProject.id+"/geometries/")

    $scope.finish = ->
      $scope.geometry.final = true
      promise = $scope.geometry.save()
      promise.then ->
        $http.post("geometry/#{$scope.geometry.id}/run")
          .success ->
            $scope.geometry.refreshStatus()

    $scope.showReport = {
      val: false
    }

    $scope.openReport = ->
      $scope.showReport.val = true
])
