controllers = angular.module('controllers')
controllers.controller("ResultMakerController", [ '$scope', '$routeParams', '$location', '$resource', '$http', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result', 'App', 'ResultData'
  ($scope,$routeParams,$location,$resource,$http,Project,Simulation,Geometry,AssignedGeometry,Result,App,ResultData)->
    $scope.template = { url: "modules/result_maker.html" }

    $scope.control = {
      updating: false
      yVar: ""
      rollPeriod: 7
    }

    $scope.variableNames = []

    $scope.$watchCollection 'selectedSimulationIds', ->
      if $scope.selectedSimulationIds.length > 0
        ResultData.variableNames($scope.selectedSimulationIds).then (variableNames) ->
          $scope.variableNames = variableNames
          $scope.plot()

    $scope.$watch 'control.yVar', ->
      $scope.plot()

    $scope.$watch 'control.rollPeriod', ->
      $scope.plot()

    $scope.graphParams = ->
      {
        simulation_ids: $scope.selectedSimulationIds.join()
        y_var: $scope.control.yVar
      }

    $scope.plot = ->
      if $scope.control.yVar != ""
        $scope.control.updating = true
        $http.get("graph",params: $scope.graphParams() )
          .success (data) ->
            $scope.graph = new Dygraph(document.getElementById("graph"), data,
            {
              highlightSeriesOpts: {
                showRangeSelector: true # this is not working for some reason
                strokeWidth: 2
                strokeBorderWidth: 1
                hightlightCirclesSize: 5
                rollPeriod: $scope.control.rollPeriod # this is not working either
                showRoller: true # this is not working either
                # basically none of the extra dygraph options want to work :(
              }
            })
            $scope.control.updating = false
])
