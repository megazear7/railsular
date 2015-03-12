controllers = angular.module('controllers')
controllers.controller("AdminController", [ '$scope', '$routeParams', '$location', '$resource', 'GeometryType', 'AttributeDescriptor'
  ($scope,$routeParams,$location,$resource,GeometryType,AttributeDescriptor)->
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.geometry_types = GeometryType.all()
    $scope.attribute_descriptors = AttributeDescriptor.all()
    $scope.simulation_attribute_descriptors = AttributeDescriptor.simulation_attribute_descriptors()

    $scope.addGeometryType = ->
      promise = GeometryType.create({name: "Name"})
      promise.then (geometry_type) ->
        geometry_type.startEdit()

    $scope.addAttributeDescriptor = (geometry_type_id) ->
      promise = AttributeDescriptor.create({name: "", attr_type: "text-input", display: "1", validation: "", usage: "", geometry_type_id: geometry_type_id})
      promise.then (attribute_descriptor) ->
        attribute_descriptor.startEdit()

    $scope.add_simulation_attribute = ->
      promise = AttributeDescriptor.create({name: "", attr_type: "text-input", display: "1", validation: "", usage: "simulation"})
      promise.then (attribute_descriptor) ->
        $scope.simulation_attribute_descriptors = AttributeDescriptor.simulation_attribute_descriptors()
        attribute_descriptor.startEdit()

    $scope.delete_simulation_attribute = (attribute_descriptor) ->
      attribute_descriptor.delete()
      $scope.simulation_attribute_descriptors = AttributeDescriptor.simulation_attribute_descriptors()
])
