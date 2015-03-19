controllers = angular.module('controllers')
controllers.controller("GeometryJobSpecificationController", [ '$scope', '$routeParams', '$location', '$resource', 'JobDescriptor'
  ($scope,$routeParams,$location,$resource,JobDescriptor)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/admin/geometry_job_specification.html" }

    $scope.job_descriptors = JobDescriptor.geometry_job_descriptors()

    $scope.delete = (job_descriptor) ->
      job_descriptor.delete()
      $scope.job_descriptors = JobDescriptor.geometry_job_descriptors()

    $scope.create = ->
      JobDescriptor.create({job_type: "geometry", script_number: 0})
        .then (job_descriptor) ->
          $scope.job_descriptors = JobDescriptor.geometry_job_descriptors()
          job_descriptor.startEdit()
])
