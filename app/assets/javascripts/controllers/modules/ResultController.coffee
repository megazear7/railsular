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

    $scope.xMin = { val: 0 }
    $scope.xMax = { val: 11 }

    $scope.data = [
      {x: 0, value: 4, otherValue: 14}
      {x: 1, value: 80, otherValue: 1}
      {x: 2, value: 38, otherValue: 11}
      {x: 3, value: 16, otherValue: 147}
      {x: 4, value: 23, otherValue: 87}
      {x: 5, value: 42, otherValue: 45}
      {x: 6, value: 4, otherValue: 14}
      {x: 7, value: 80, otherValue: 1}
      {x: 8, value: 38, otherValue: 11}
      {x: 9, value: 16, otherValue: 147}
      {x: 10, value: 23, otherValue: 87}
      {x: 11, value: 42, otherValue: 45}
    ]

    $scope.options = {
      axes: {
        x: {
          key: 'x'
          labelFunction: (value) ->
            return value
          type: 'linear'
          min: $scope.xMin.val
          max: $scope.xMax.val
        }
        y: {type: 'linear', min: 0, max: 150, ticks: 20}
      },
      series: [
        {y: 'value', color: 'steelblue', thickness: '2px', label: 'simulation 1'},
        {y: 'otherValue', color: 'lightsteelblue', thickness: '2px', label: 'simulation 2'}
      ]
      lineMode: 'linear'
      tension: 0.7
      tooltip: {
        mode: 'scrubber'
        formatter: (x, y, series) ->
          series.label
      },
      drawLegend: true
      columnsHGap: 5
    }
])
