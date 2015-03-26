controllers = angular.module('controllers')
controllers.controller("ResultController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry,Result)->
    $scope.template = { url: "modules/result.html" }

    $scope.addableSimulations = ->
      sims = $scope.activeProject.simulations_where(status: "Complete")
      addableSims = { }
      angular.forEach sims, (sim) ->
        if ! (sim.id of $scope.result.simulations())
          addableSims[sim.id] = sim
      addableSims
])
