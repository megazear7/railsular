controllers = angular.module('controllers')
controllers.controller("NavController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', '$http', 'App'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,$http,App)->
    $scope.template = { url: "modules/nav.html" }

    $scope.appName = App.find(1).name

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

    $scope.openMenu = ->
      menuLeft = document.getElementById('cbp-spmenu-s1')
      classie.add(menuLeft, 'cbp-spmenu-open')

    $scope.closeMenu = ->
      menuLeft = document.getElementById('cbp-spmenu-s1')
      classie.remove(menuLeft, 'cbp-spmenu-open')
])
