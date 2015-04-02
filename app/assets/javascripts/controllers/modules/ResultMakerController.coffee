controllers = angular.module('controllers')
controllers.controller("ResultMakerController", [ '$scope', '$routeParams', '$location', '$resource', '$http', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result', 'App'
  ($scope,$routeParams,$location,$resource,$http,Project,Simulation,Geometry,AssignedGeometry,Result,App)->
    $scope.template = { url: "modules/result_maker.html" }

    $scope.result_vars = []
    angular.forEach App.find(1).result_vars(), (result_var, id) ->
      $scope.result_vars.push result_var.name

    $scope.simulations = $scope.activeProject.simulations()
    $scope.y_var = { val: "" }

    selectedSimulationIds = [ ]

    $scope.graphParams = ->
      {
        simulation_ids: selectedSimulationIds.join()
        y_var: $scope.y_var.val
      }

    $scope.plot = ->
      $http.get("graph",params: $scope.graphParams() )
        .success (data) ->
          $scope.graph = new Dygraph(document.getElementById("graph"), data,
          {
            highlightSeriesOpts: {
              showRangeSelector: true # this is not working for some reason
              strokeWidth: 2
              strokeBorderWidth: 1
              hightlightCirclesSize: 5
            }
          })

    $scope.isSelected = (sim) ->
      return sim.id in selectedSimulationIds

    $scope.removeSimulation = (sim) ->
      index = selectedSimulationIds.indexOf(sim.id)
      if (index > -1)
        selectedSimulationIds.splice(index, 1)

    $scope.addSimulation = (sim) ->
      selectedSimulationIds.push(sim.id)
])
