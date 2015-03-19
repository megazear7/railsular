controllers = angular.module('controllers')
controllers.controller("GeometryJobSpecificationController", [ '$scope', '$routeParams', '$location', '$resource'
  ($scope,$routeParams,$location,$resource)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/admin/geometry_job_specification.html" }
])
