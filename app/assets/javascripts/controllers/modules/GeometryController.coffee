controllers = angular.module('controllers')
controllers.controller("GeometryController", [ '$scope', '$routeParams', '$location', '$resource', '$http'
  ($scope,$routeParams,$location,$resource,$http)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/geometry.html" }

    $scope.action = "/geometry/#{$scope.geometry.id}/update_file"

    $scope.delete = ->
      $scope.geometry.delete()
      $location.path("projects/"+$scope.activeProject.id+"/geometries/")

    $scope.finish = ->
      $scope.geometry.final = true
      promise = $scope.geometry.save()
      promise.then ->
        $http.post("/geometry/#{$scope.geometry.id}/run")
          .success (data) ->
            console.log(data)
          .error (data) ->
            console.log("error running simulation")

    $scope.report = ->
      alert("Reporting Geometry...")
])
