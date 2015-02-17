controllers = angular.module('controllers')
controllers.controller("SimNavController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.title = "Sim Nav"
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/sim_nav.html" }

    # the responsibility of this controller is to manage a list of simulations
    # This could be in a tree form or just a list form. it needs a link to
    # /projects/<current_project_id>/geometries. If a simulation is selected in
    # this controller is should affect the global selected simulation variable.
])
