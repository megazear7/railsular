controllers = angular.module('controllers')
controllers.controller("ProjectsController", [ '$scope', '$routeParams', '$location', '$resource', 'ProjectService',
  ($scope,$routeParams,$location,$resource,ProjectService)->
    $scope.title = "Projects"
    $scope.message = "Hello this is the projects controller"
    $scope.link = (url) -> $location.path("/#{url}")

    # the projects controller simply lists the projects and lets you select one (which takes you to the simulations controller)

    $scope.projects = ProjectService
])
