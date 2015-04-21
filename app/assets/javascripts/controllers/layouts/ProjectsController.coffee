controllers = angular.module('controllers')
controllers.controller("ProjectsController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'App'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,App)->
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.appName = App.find(1).name
    $scope.projects = Project.all()
    $scope.shouldOpenMenu = true

    projectArray = []
    $scope.data = []

    counter = 0
    yMax = 0

    angular.forEach $scope.projects, (project) ->
      projectArray.push project
      sims = 0
      geos = 0
      complexity = 0

      angular.forEach project.simulations(), (simulation) ->
        sims++
        complexity++
        angular.forEach simulation.reports, ->
          complexity++
        angular.forEach simulation.assigned_geometries, ->
          complexity++

      angular.forEach project.geometries(), (geometry) ->
        geos++
        complexity++
        angular.forEach geometry.reports, ->
          complexity++

      angular.forEach project.reports(), (geometry) ->
        complexity++

      complexity = complexity / 6

      if sims > yMax
        yMax = sims
      if geos > yMax
        yMax = geos
      if complexity > yMax
        yMax = complexity

      $scope.data.push { x: counter, complexity: complexity, sims: sims, geos: geos }
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
        {y: 'complexity', color: '#3F5D7D', type: 'column', label: 'Project Complexity'}
        {y: 'sims', color: '#279B61', type: 'column', label: 'Simulation Count'}
        {y: 'geos', color: '#008AB8', type: 'column', label: 'Geometry Count'}
      ],
      stacks: [],
      lineMode: 'linear',
      tension: 0.7,
      tooltip: {
        mode: 'scrubber'
        formatter: (x, y, series) ->
          return "#{series.label}: #{y}"
      },
      drawDots: true,
      columnsHGap: 5
    }
])
