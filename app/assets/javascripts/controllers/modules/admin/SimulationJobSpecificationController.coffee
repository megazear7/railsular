controllers = angular.module('controllers')
controllers.controller("SimulationJobSpecificationController", [ '$scope', '$routeParams', '$location', '$resource', 'JobDescriptor'
  ($scope,$routeParams,$location,$resource,JobDescriptor)->
    $scope.template = { url: "modules/admin/simulation_job_specification.html" }

    $scope.job_descriptors = JobDescriptor.simulation_job_descriptors()

    $scope.delete = (job_descriptor) ->
      job_descriptor.delete()
      $scope.job_descriptors = JobDescriptor.simulation_job_descriptors()

    nextScriptNumber = ->
      max = 0
      angular.forEach $scope.job_descriptors, (job_desc) ->
        if job_desc.script_number > max
          max = job_desc.script_number
      return max + 1

    $scope.create = ->
      JobDescriptor.create({job_type: "simulation", script_number: nextScriptNumber()})
        .then (job_descriptor) ->
          $scope.job_descriptors = JobDescriptor.simulation_job_descriptors()
          job_descriptor.startEdit()
])
