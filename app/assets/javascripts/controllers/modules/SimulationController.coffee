controllers = angular.module('controllers')
controllers.controller("SimulationController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.title = "Simulation"
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/simulation.html" }

    $scope.startEdit = ->
      $scope.simulation.editing = true

    $scope.stopEdit = ->
      # todo save this to rails api
      $scope.simulation.editing = false

    # the responsibility of this controller is to manage a single given simulation.
    # this controller expects $scope.simulation to be set to a simulation json object or
    # to be set to a json object of the following form:
    # { simulationNotSet: true, message: "some message..." }
    # in which case the message will appear in lieu of a simulation
])
