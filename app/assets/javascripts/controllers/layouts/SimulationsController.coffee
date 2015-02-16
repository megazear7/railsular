controllers = angular.module('controllers')
controllers.controller("SimulationsController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.title = "Simulations"
    $scope.message = "Hello this is the simulations controller"
    $scope.link = (url) -> $location.path("/#{url}")
])
