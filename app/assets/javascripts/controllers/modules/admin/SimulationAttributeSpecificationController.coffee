controllers = angular.module('controllers')
controllers.controller("SimulationAttributeSpecificationController", [ '$scope', '$routeParams', '$location', '$resource', 'AttributeDescriptor', 'AttributeDescriptorValue'
  ($scope,$routeParams,$location,$resource,AttributeDescriptor,AttributeDescriptorValue)->
    $scope.template = { url: "modules/admin/simulation_attribute_specification.html" }

    $scope.simulation_attribute_descriptors = AttributeDescriptor.simulation_attribute_descriptors()

    $scope.add_simulation_attribute = ->
      promise = AttributeDescriptor.create({name: "", attr_type: "text-input", display: "1", validation: "", usage: "simulation"})
      promise.then (attribute_descriptor) ->
        $scope.simulation_attribute_descriptors = AttributeDescriptor.simulation_attribute_descriptors()
        attribute_descriptor.startEdit()

    $scope.delete_simulation_attribute = (attribute_descriptor) ->
      attribute_descriptor.delete()
      $scope.simulation_attribute_descriptors = AttributeDescriptor.simulation_attribute_descriptors()

    $scope.addAttributeDescriptorValue = (attribute_descriptor) ->
      promise = AttributeDescriptorValue.create({value: "Value", attribute_descriptor_id: attribute_descriptor.id})
      promise.then (attribute_descriptor_value) ->
        attribute_descriptor_value.startEdit()
])
