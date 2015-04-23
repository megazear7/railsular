controllers = angular.module('controllers')
controllers.controller("NavDrawerController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'App'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,App)->
    $scope.template = { url: "modules/nav_drawer.html" }

    $scope.addProject = ->
      angular.forEach $scope.projects, (value, key) ->
        value.stopEdit()
      Project.create({name: "Project Name", description: ""})
        .then (project) ->
          project.startEdit()
          $scope.openMenu()

    $scope.editProject = (project) ->
      angular.forEach $scope.projects, (value, key) ->
        value.editing = false
      project.editing = true
      $location.path("projects")

    $scope.stopEdit = (project) ->
      project.stopEdit()
      $scope.link("projects/#{project.id}")
])
