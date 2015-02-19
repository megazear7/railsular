controllers = angular.module('controllers')
controllers.controller("NavController", [ '$scope', '$routeParams', '$location', '$resource', 'DataProvider',
  ($scope,$routeParams,$location,$resource,DataProvider)->
    $scope.template = { url: "modules/nav_module.html" }
    $scope.title = "Nav Module Controller"
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.addSim = (project) ->
      sim = DataProvider.create.simulation({ name: "Simulation Name", description: "Description", editing: true, status: "queued", project_id: $scope.activeProject.id})
      $location.path("projects/"+$scope.activeProject.id+"/simulations/"+sim.id)

    $scope.addGeo = (project) ->
      geo = DataProvider.create.geometry({ name: "Geometry Name", description: "Description", editing: true, project_id: $scope.activeProject.id})
      $location.path("projects/"+$scope.activeProject.id+"/geometries/"+geo.id)

    $scope.addProject = ->
      angular.forEach($scope.projects, (value, key) ->
        value.editing = false
      )
      DataProvider.create.project({ name: "Project Name", description: "Description", editing: true})
      $location.path("projects/")

    $scope.editProject = (project) ->
      angular.forEach($scope.projects, (value, key) ->
        value.editing = false
      )
      project.editing = true
      $location.path("projects")
])
