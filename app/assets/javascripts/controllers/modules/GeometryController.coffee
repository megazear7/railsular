controllers = angular.module('controllers')
controllers.controller("GeometryController", [ '$scope', '$routeParams', '$location', '$resource', '$http', '$interval'
  ($scope,$routeParams,$location,$resource,$http,$interval)->
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

    $scope.showReport = false

    $scope.openReport = ->
      $scope.showReport = true

    $scope.closeReport = ->
      $scope.showReport = false

    $scope.sendReport = (reportMessage) ->
      $scope.showReport = false
      $http.get("geometry/#{$scope.geometry.id}/report", params: {message: reportMessage})
        .success ->
          alert("Report sent")
        .error ->
          alert("Error sending report")
])
