controllers = angular.module('controllers')
controllers.controller("AdminController", [ '$scope', '$routeParams', '$location', '$resource', 'GeometryType', 'AttributeDescriptor', 'AttributeDescriptorValue'
  ($scope,$routeParams,$location,$resource,GeometryType,AttributeDescriptor,AttributeDescriptorValue)->
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.stopEditing = (attribute_descriptor) ->
      attribute_descriptor.stopEdit()
      angular.forEach attribute_descriptor.attribute_descriptor_values(), (val, id) ->
        val.stopEdit()
])
