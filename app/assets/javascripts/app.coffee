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
        templateUrl: "layouts/home.html"
        controller: 'HomeController'
      ).when('/plan',
        templateUrl: "layouts/plan.html"
        controller: 'PlanController'
      ).when('/todo',
        templateUrl: "layouts/todo.html"
        controller: 'TodoController'
      ).when('/projects',
        templateUrl: "layouts/projects.html"
        controller: 'ProjectsController'
      ).when('/simulations',
        templateUrl: "layouts/simulations.html"
        controller: 'SimulationsController'
      ).when('/geometries',
        templateUrl: "layouts/geometries.html"
        controller: 'GeometriesController'
      )
])

controllers = angular.module('controllers',[])
