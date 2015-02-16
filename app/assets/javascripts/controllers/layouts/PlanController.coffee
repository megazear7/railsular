controllers = angular.module('controllers')
controllers.controller("PlanController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.title = "Planning"
    $scope.message = "This is the page-wide angular controller for the '/plan' page. I am allowed to do client side page navigation, but I am not a 'module' per se. I am a web page that manages modules. Therefore, I load modules which in turn will do the heavy lifting for this pages functionality."
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.back = -> $location.path("/")
])
