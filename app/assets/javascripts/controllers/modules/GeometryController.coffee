controllers = angular.module('controllers')
controllers.controller("GeometryController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.title = "Geometry"
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/geometry.html" }
])
