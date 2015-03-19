controllers = angular.module('controllers')
controllers.controller("SimulationJobSpecificationController", [ '$scope', '$routeParams', '$location', '$resource'
  ($scope,$routeParams,$location,$resource)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/admin/simulation_job_specification.html" }
])
