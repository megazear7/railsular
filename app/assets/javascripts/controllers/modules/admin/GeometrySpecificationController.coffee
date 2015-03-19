controllers = angular.module('controllers')
controllers.controller("GeometrySpecificationController", [ '$scope', '$routeParams', '$location', '$resource', 'AttributeDescriptor', 'GeometryType'
  ($scope,$routeParams,$location,$resource,AttributeDescriptor,GeometryType)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/admin/geometry_specification.html" }

    $scope.attribute_descriptors = AttributeDescriptor.all()

    $scope.geometry_types = GeometryType.all()

    $scope.addGeometryType = ->
      promise = GeometryType.create({name: "Name"})
      promise.then (geometry_type) ->
        geometry_type.startEdit()

    $scope.addAttributeDescriptor = (geometry_type_id) ->
      promise = AttributeDescriptor.create({name: "", attr_type: "text-input", display: "1", validation: "", usage: "", geometry_type_id: geometry_type_id})
      promise.then (attribute_descriptor) ->
        attribute_descriptor.startEdit()


])
