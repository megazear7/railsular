controllers = angular.module('controllers')
controllers.controller("ProjectsController", [ '$scope', '$routeParams', '$location', '$resource', 'DataProvider',
  ($scope,$routeParams,$location,$resource,DataProvider)->
    $scope.title = "Projects"
    $scope.message = "Hello this is the projects controller"
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.projects = DataProvider.projects()
])
