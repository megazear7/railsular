receta = angular.module('receta',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

standard_resolve = {
    geometryData: (Geometry) ->
      Geometry.promise
    geometryTypeData: (Geometry) ->
      Geometry.geometry_type_promise
    smulationData: (Simulation) ->
      Simulation.promise
    projectData: (Project) ->
      Project.promise
    assignedGeometryData: (AssignedGeometry) ->
      AssignedGeometry.promise
    simulationAttributesData: (Simulation) ->
      Simulation.simulation_attributes_promise
  }

receta.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->

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
      )
])

controllers = angular.module('controllers',[])
