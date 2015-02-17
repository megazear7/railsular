controllers = angular.module('controllers')
controllers.controller("NavController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.template = { url: "modules/nav_module.html" }
    $scope.title = "Nav Module Controller"
    $scope.link = (url) -> $location.path("/#{url}")

    # functionality differs depending on whether $scope.project is set or not
])
