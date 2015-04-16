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

    nextScriptNumber = ->
      max = 0
      angular.forEach $scope.job_descriptors, (job_desc) ->
        if job_desc.script_number > max
          max = job_desc.script_number
      return max + 1

    $scope.create = ->
      JobDescriptor.create({job_type: $scope.geometry_type.name, script_number: nextScriptNumber()})
        .then (job_descriptor) ->
          $scope.job_descriptors = JobDescriptor.where({job_type: $scope.geometry_type.name})
          job_descriptor.startEdit()
])
