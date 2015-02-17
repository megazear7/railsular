controllers = angular.module('controllers')
controllers.controller("GeoNavController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.title = "Geo Nav"
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/geo_nav.html" }

    # the responsibility of this controller is to manage a list of geometries
    # This could be in a tree form or just a list form. it needs a link to
    # /projects/<current_project_id>/simulations. If a geometry is selected in
    # this controller is should affect the global selected geometry variable.
])
