controllers = angular.module('controllers')
controllers.controller("GeometryAttributeSpecificationController", [ '$scope', '$routeParams', '$location', '$resource', 'AttributeDescriptor', 'GeometryType'
  ($scope,$routeParams,$location,$resource,AttributeDescriptor,GeometryType)->
    $scope.template = { url: "modules/admin/geometry_attribute_specification.html" }

    $scope.init = (geometry_type) ->
      $scope.geometry_type = geometry_type

    $scope.attribute_descriptors = AttributeDescriptor.all()

    $scope.addAttributeDescriptor = (geometry_type_id) ->
      promise = AttributeDescriptor.create({name: "", attr_type: "text-input", display: "1", validation: "", usage: "", geometry_type_id: geometry_type_id})
      promise.then (attribute_descriptor) ->
        attribute_descriptor.startEdit()


])
