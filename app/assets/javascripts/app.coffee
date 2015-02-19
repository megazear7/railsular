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

receta.factory('ProjectService', ->
  {
    1:
      {
        name: "Test Project"
        id: 1
        description: "test project description"
        editing: false
        simulations:
          {
            1: {name: "Test Sim", id: 1, description: "blah blaj", status: "Queued", editing: false}
            3: {name: "SimB", id: 3, description: "blah blah", status: "Queued", editing: false}
            4: {name: "AnotherSim", id: 4, description: "blah", status: "Queued", editing: false}
          }
        geometries:
          {
            1: {name: "GEO B", id: 1, description: "blah", editing: false}
            2: {name: "Geometry Again", id: 2, description: "blah", editing: false}
          }
      }
    2:
      {
        name: "Project Two"
        id: 2
        description: "test project description"
        editing: false
        simulations:
          {
            2: {name: "TestAgainSim", id: 2, description: "blah blaj", status: "Queued", editing: false}
            5: {name: "SimCCC", id: 5, description: "blah blah", status: "Queued", editing: false}
            6: {name: "YetAnotherSim", id: 6, description: "blah", status: "Queued", editing: false}
            8: {name: "Simulation Test", id: 8, description: "blah", status: "Queued", editing: false}
            11: {name: "Sim Test", id: 11, description: "blah", status: "Queued", editing: false}
          }
        geometries:
          {
            3: {name: "GEO C", id: 3, description: "blah", editing: false}
            4: {name: "Geo Again", id: 4, description: "blah", editing: false}
          }
      }
  }
)

controllers = angular.module('controllers',[])
