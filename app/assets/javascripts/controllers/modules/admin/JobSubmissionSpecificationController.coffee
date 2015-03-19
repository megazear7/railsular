controllers = angular.module('controllers')
controllers.controller("JobSubmissionSpecificationController", [ '$scope', '$routeParams', '$location', '$resource', '$http'
  ($scope,$routeParams,$location,$resource,$http)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/admin/job_submission_specification.html" }

    $scope.editing = false

    $scope.startEditing = ->
      $scope.editing = true

    $scope.stopEditing = ->
      $scope.editing = false
      $http.post("admin/data/update", $scope.app)
        .error (data) ->
          alert('server had error saving app overview')
          $scope.app = data

    $scope.app = { }
    $http.get("admin/data/show")
      .success (data) ->
        $scope.app = data
])
