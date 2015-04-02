controllers = angular.module('controllers')
controllers.controller("JobSubmissionSpecificationController", [ '$scope', '$routeParams', '$location', '$resource', '$http', 'App'
  ($scope,$routeParams,$location,$resource,$http,App)->
    $scope.template = { url: "modules/admin/job_submission_specification.html" }

    $scope.app = App.find(1)
])
