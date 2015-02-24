controllers = angular.module('controllers')
controllers.controller("GeometryController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/geometry.html" }

    $scope.delete = ->
      $scope.geometry.delete()
      $location.path("projects/"+$scope.activeProject.id+"/geometries/")

    $scope.report = ->
      alert("Reporting Geometry...")
])
