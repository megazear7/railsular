receta = angular.module('receta',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

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
        templateUrl: "layouts/project.html"
        controller: 'ProjectController'
      ).when('/projects/:project_id/simulations/:simulation_id',
        templateUrl: "layouts/simulations.html"
        controller: 'SimulationsController'
      ).when('/projects/:project_id/simulations',
        templateUrl: "layouts/project.html"
        controller: 'ProjectController'
      ).when('/projects/:project_id/geometries/:geometry_id',
        templateUrl: "layouts/geometries.html"
        controller: 'GeometriesController'
      ).when('/projects/:project_id/geometries',
        templateUrl: "layouts/project.html"
        controller: 'ProjectController'
      )
])

controllers = angular.module('controllers',[])
