controllers = angular.module('controllers')
controllers.controller("AdminController", [ '$scope', '$routeParams', '$location', '$resource', 'GeometryType'
  ($scope,$routeParams,$location,$resource,GeometryType)->
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.geometry_types = GeometryType.all()

    $scope.addGeometryType = ->
      promise = GeometryType.create({name: "Name"})
      promise.then (geometry_type) ->
        geometry_type.startEdit()
])
