controllers = angular.module('controllers')
controllers.controller("SimulationJobSpecificationController", [ '$scope', '$routeParams', '$location', '$resource', 'JobDescriptor'
  ($scope,$routeParams,$location,$resource,JobDescriptor)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/admin/simulation_job_specification.html" }

    $scope.job_descriptors = JobDescriptor.simulation_job_descriptors()

    $scope.delete = (job_descriptor) ->
      job_descriptor.delete()
      $scope.job_descriptors = JobDescriptor.simulation_job_descriptors()

    $scope.create = ->
      JobDescriptor.create({job_type: "simulation", script_number: 0})
        .then (job_descriptor) ->
          $scope.job_descriptors = JobDescriptor.simulation_job_descriptors()
          job_descriptor.startEdit()
])
