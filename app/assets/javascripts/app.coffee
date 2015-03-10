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
        resolve:
          {
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
      ).when('/projects',
        templateUrl: "layouts/projects.html"
        controller: 'ProjectsController'
        resolve:
          {
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
      ).when('/projects/:project_id',
        templateUrl: "layouts/project.html"
        controller: 'ProjectController'
        resolve:
          {
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
      ).when('/projects/:project_id/simulations/:simulation_id',
        templateUrl: "layouts/simulations.html"
        controller: 'SimulationsController'
        resolve:
          {
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
      ).when('/projects/:project_id/simulations',
        templateUrl: "layouts/project.html"
        controller: 'ProjectController'
        resolve:
          {
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
      ).when('/projects/:project_id/geometries/:geometry_id',
        templateUrl: "layouts/geometries.html"
        controller: 'GeometriesController'
        resolve:
          {
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
      ).when('/projects/:project_id/geometries',
        templateUrl: "layouts/project.html"
        controller: 'ProjectController'
        resolve:
          {
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
      )
])

controllers = angular.module('controllers',[])

# file upload button styling:
$(document).on "change", ".btn-file :file", ->
  input = $(this)
  numFiles = (if input.get(0).files then input.get(0).files.length else 1)
  label = input.val().replace(/\\/g, "/").replace(/.*\//, "")
  input.trigger "fileselect", [
    numFiles
    label
  ]
$(document).ready ->
  $(".btn-file :file").on "fileselect", (event, numFiles, label) ->
    $(".upload-file-text").text label
