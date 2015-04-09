controllers = angular.module('controllers')
controllers.controller("ResultMakerController", [ '$scope', '$routeParams', '$location', '$resource', '$http', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result', 'App'
  ($scope,$routeParams,$location,$resource,$http,Project,Simulation,Geometry,AssignedGeometry,Result,App)->
    $scope.template = { url: "modules/result_maker.html" }

    $scope.updating = {
      val: false
    }

    $scope.result_vars = []
    angular.forEach App.find(1).result_vars(), (result_var, id) ->
      $scope.result_vars.push result_var.name

    $scope.y_var = { val: "" }

    $scope.$watchCollection 'selectedSimulationIds', ->
      $scope.plot()

    $scope.$watch 'y_var.val', ->
      $scope.plot()

    $scope.graphParams = ->
      {
        simulation_ids: $scope.selectedSimulationIds.join()
        y_var: $scope.y_var.val
      }

    $scope.plot = ->
      if $scope.y_var.val != ""
        $scope.updating.val = true
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
            $scope.updating.val = false
])
