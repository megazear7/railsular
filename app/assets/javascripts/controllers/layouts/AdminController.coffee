controllers = angular.module('controllers')
controllers.controller("AdminController", [ '$scope', '$routeParams', '$location', '$resource', 'GeometryType'
  ($scope,$routeParams,$location,$resource,GeometryType)->
    $scope.link = (url) -> $location.path("/#{url}")

    console.log(GeometryType.all())
])
