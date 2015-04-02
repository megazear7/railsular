simapp = angular.module('simapp',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive',
  'n3-line-chart'
])

standard_resolve = {
    geometryData: (Geometry) ->
      Geometry.promise
    geometryTypeOverviewData: (Geometry) ->
      Geometry.geometry_type_overview_promise
    smulationData: (Simulation) ->
      Simulation.promise
    projectData: (Project) ->
      Project.promise
    assignedGeometryData: (AssignedGeometry) ->
      AssignedGeometry.promise
    simulationAttributesData: (Simulation) ->
      Simulation.simulation_attributes_promise
    geometryTypesData: (GeometryType) ->
      GeometryType.promise
    resultsData: (Result) ->
      Result.promise
    resultsSimulationsData: (Result) ->
      Result.results_simulations_promise
    appsData: (App) ->
      App.promise
    resultVarData: (ResultVar) ->
      ResultVar.promise
  }

simapp.config([ '$routeProvider', 'flashProvider', '$httpProvider',
  ($routeProvider,flashProvider,$httpProvider)->

    $httpProvider.interceptors.push ->
      {
        request: (config) ->
          # if you want a url prefix to the http requests made by the $http service
          # edit the prefix variable (don't put slashed at begining or end)
          prefix = ""
          config.url = prefix + config.url
          return config
      }

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
      .when('/admin',
        templateUrl: "layouts/admin.html"
        controller: 'AdminController'
        resolve: {
          geometryTypeData: (GeometryType) ->
            GeometryType.promise
          attributeDescriptorData: (AttributeDescriptor) ->
            AttributeDescriptor.promise
          attributeDescriptorValueData: (AttributeDescriptorValue) ->
            AttributeDescriptorValue.promise
          jobDescriptorData: (JobDescriptor) ->
            JobDescriptor.promise
          appsData: (App) ->
            App.promise
          resultVarData: (ResultVar) ->
            ResultVar.promise
        }
      ).when('/',
        templateUrl: "layouts/projects.html"
        controller: 'ProjectsController'
        resolve: standard_resolve
      ).when('/projects',
        templateUrl: "layouts/projects.html"
        controller: 'ProjectsController'
        resolve: standard_resolve
      ).when('/projects/:project_id',
        templateUrl: "layouts/project.html"
        controller: 'ProjectController'
        resolve: standard_resolve
      ).when('/projects/:project_id/simulations/:simulation_id',
        templateUrl: "layouts/simulations.html"
        controller: 'SimulationsController'
        resolve: standard_resolve
      ).when('/projects/:project_id/simulations',
        templateUrl: "layouts/project.html"
        controller: 'ProjectController'
        resolve: standard_resolve
      ).when('/projects/:project_id/geometries/:geometry_id',
        templateUrl: "layouts/geometries.html"
        controller: 'GeometriesController'
        resolve: standard_resolve
      ).when('/projects/:project_id/geometries',
        templateUrl: "layouts/project.html"
        controller: 'ProjectController'
        resolve: standard_resolve
      ).when('/projects/:project_id/results/:result_id',
        templateUrl: "layouts/results.html"
        controller: 'ResultsController'
        resolve: standard_resolve
      ).when('/projects/:project_id/results',
        templateUrl: "layouts/results.html"
        controller: 'ResultsController'
        resolve: standard_resolve
      ).when('/projects/:project_id/results/lineplot',
        templateUrl: "layouts/results.html"
        controller: 'ResultsController'
        resolve: standard_resolve
      ).when('/projects/:project_id/results/images',
        templateUrl: "layouts/results.html"
        controller: 'ResultsController'
        resolve: standard_resolve
      ).when('/projects/:project_id/results/movies',
        templateUrl: "layouts/results.html"
        controller: 'ResultsController'
        resolve: standard_resolve
      )
])

# Keep the connection to OSC alive
setInterval(
  ->
    $.get('projects?open_identifier='+window.user_auth_token)
  120000
)

controllers = angular.module('controllers',[])
