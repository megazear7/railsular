controllers = angular.module('controllers')
controllers.controller("GeometriesController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.title = "Geometries"
    $scope.message = "Hello this is the geometries controller"
    $scope.link = (url) -> $location.path("/#{url}")
])
