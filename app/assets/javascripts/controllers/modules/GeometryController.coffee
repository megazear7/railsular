controllers = angular.module('controllers')
controllers.controller("GeometryController", [ '$scope', '$routeParams', '$location', '$resource', '$http'
  ($scope,$routeParams,$location,$resource,$http)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/geometry.html" }

    $scope.action = "/geometry/#{$scope.geometry.id}/update_file"

    $scope.delete = ->
      $scope.geometry.delete()
      $location.path("projects/"+$scope.activeProject.id+"/geometries/")

    $scope.uploadFile = (files) ->
      fd = new FormData()
      #Take the first selected file
      fd.append("geo", files[0])
      $http.post("geometry/#{$scope.geometry.id}/update_file", fd, {
        withCredentials: true,
        headers: {'Content-Type': undefined },
        transformRequest: angular.identity
      }).success (data) ->
        $scope.geometry.geo_file_name = data.geometry.geo_file_name

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
