controllers = angular.module('controllers')
controllers.controller("GeometryJobSpecificationController", [ '$scope', '$routeParams', '$location', '$resource', 'JobDescriptor'
  ($scope,$routeParams,$location,$resource,JobDescriptor)->
    $scope.template = { url: "modules/admin/geometry_job_specification.html" }

    $scope.init = (geometry_type) ->
      $scope.geometry_type = geometry_type
      $scope.job_descriptors = JobDescriptor.where({job_type: $scope.geometry_type.name})

    $scope.delete = (job_descriptor) ->
      job_descriptor.delete()
      $scope.job_descriptors = JobDescriptor.where({job_type: $scope.geometry_type.name})

    $scope.create = ->
      JobDescriptor.create({job_type: $scope.geometry_type.name, script_number: 0})
        .then (job_descriptor) ->
          $scope.job_descriptors = JobDescriptor.where({job_type: $scope.geometry_type.name})
          job_descriptor.startEdit()
])
