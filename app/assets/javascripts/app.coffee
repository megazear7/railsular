receta = angular.module('receta',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])
.run( (Project) -> console.log('Project service is ready') )
.run( (Simulation) -> console.log('Simulation service is ready') )
.run( (Geometry) -> console.log('Geometry service is ready') )
.filter('titlize', ->
  (str) ->
    str[0].toUpperCase() + str.slice(1)
)


receta.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
      .when('/',
        templateUrl: "layouts/projects.html"
        controller: 'ProjectsController'
      ).when('/projects',
        templateUrl: "layouts/projects.html"
        controller: 'ProjectsController'
      ).when('/projects/:project_id',
        templateUrl: "layouts/simulations.html"
        controller: 'SimulationsController'
      ).when('/projects/:project_id/simulations/:simulation_id',
        templateUrl: "layouts/simulations.html"
        controller: 'SimulationsController'
      ).when('/projects/:project_id/simulations',
        templateUrl: "layouts/simulations.html"
        controller: 'SimulationsController'
      ).when('/projects/:project_id/geometries/:geometry_id',
        templateUrl: "layouts/geometries.html"
        controller: 'GeometriesController'
      ).when('/projects/:project_id/geometries',
        templateUrl: "layouts/geometries.html"
        controller: 'GeometriesController'
      )
])

controllers = angular.module('controllers',[])
