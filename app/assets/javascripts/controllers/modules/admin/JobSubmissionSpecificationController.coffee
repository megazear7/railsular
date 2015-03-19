controllers = angular.module('controllers')
controllers.controller("JobSubmissionSpecificationController", [ '$scope', '$routeParams', '$location', '$resource'
  ($scope,$routeParams,$location,$resource)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/admin/job_submission_specification.html" }
])
