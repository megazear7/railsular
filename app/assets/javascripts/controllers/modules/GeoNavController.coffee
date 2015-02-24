controllers = angular.module('controllers')
controllers.controller("GeoNavController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.title = "Geo Nav"
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/geo_nav.html" }
])
