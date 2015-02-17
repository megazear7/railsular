controllers = angular.module('controllers')
controllers.controller("NavController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.template = { url: "modules/nav_module.html" }
    $scope.title = "Nav Module Controller"
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.addSim = (project) ->
      # todo query API for new blank simulation and get its id
      newSimId = 20
      project.simulations[newSimId] = { name: "", description: "", id: newSimId, status: "queued" }
      $location.path("projects/"+$scope.activeProject.id+"/simulations/"+newSimId)

    $scope.addGeo = (project) ->
      # todo query API for new blank geometry and get its id
      newGeoId = 20
      project.geometries[newGeoId] = { name: "", description: "", id: newGeoId }
      $location.path("projects/"+$scope.activeProject.id+"/geometries/"+newGeoId)

    $scope.addProject = ->
      # todo query API for new blank simulation and get its id
      newProjectId = 20
      $scope.projects[newProjectId] = { name: "Project Name", description: "Description", id: newProjectId, editing: true }
      $location.path("projects")

    $scope.editProject = (project) ->
      project.editing = true
      $location.path("projects")
])
