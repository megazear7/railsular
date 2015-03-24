controllers = angular.module('controllers')
controllers.controller("GeometrySpecificationController", [ '$scope', '$routeParams', '$location', '$resource', 'AttributeDescriptor', 'GeometryType'
  ($scope,$routeParams,$location,$resource,AttributeDescriptor,GeometryType)->
    $scope.template = { url: "modules/admin/geometry_specification.html" }

    $scope.geometry_types = GeometryType.all()

    $scope.addGeometryType = ->
      promise = GeometryType.create({name: "Name"})
      promise.then (geometry_type) ->
        geometry_type.startEdit()


])
