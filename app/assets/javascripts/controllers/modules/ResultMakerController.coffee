controllers = angular.module('controllers')
controllers.controller("ResultMakerController", [ '$scope', '$routeParams', '$location', '$resource', '$http', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result', 'App'
  ($scope,$routeParams,$location,$resource,$http,Project,Simulation,Geometry,AssignedGeometry,Result,App)->
    $scope.template = { url: "modules/result_maker.html" }

    $scope.result_vars = []
    angular.forEach App.find(1).result_vars(), (result_var, id) ->
      $scope.result_vars.push result_var.name

    $scope.y_var = { val: "" }


    $scope.graphParams = ->
      {
        simulation_ids: $scope.selectedSimulationIds.join()
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

    $scope.selectedSims = ->
      sims = {}
      angular.forEach $scope.selectedSimulationIds, (id) ->
        sims[id] = Simulation.find(id)
      sims
])
