controllers = angular.module('controllers')
controllers.controller("ProjectsController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry)->
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.projects = Project.all()
    $scope.shouldOpenMenu = true

    projectArray = []
    $scope.data = []

    counter = 0
    yMax = 0
    angular.forEach $scope.projects, (project) ->
      projectArray.push project
      y = 0
      angular.forEach project.simulations(), ->
        y++
      angular.forEach project.geometries(), ->
        y++
      if y > yMax
        yMax = y
      $scope.data.push { x: counter, value: y }
      counter++

    projectCount = projectArray.length

    $scope.options = {
      axes: {
        x: {
          key: 'x'
          labelFunction: (value) ->
            value = parseInt(value)
            if value >= 0 and value <= projectCount - 1
              projectArray[value].name
            else
              ""
          type: 'linear'
          min: -1
          max: projectCount
          ticks: projectCount
        }
        y: {
          min: 0
          max: yMax
          ticks: 10
        }
      }
      series: [
        {y: 'value', color: 'steelblue', type: 'column', label: 'Project Complexity'}
      ],
      stacks: [],
      lineMode: 'linear',
      tension: 0.7,
      tooltip: {
        mode: 'scrubber'
        formatter: (x, y, series) ->
          return 'size'
      },
      drawDots: true,
      columnsHGap: 5
    }
])
