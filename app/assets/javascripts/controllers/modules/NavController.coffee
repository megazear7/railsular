controllers = angular.module('controllers')
controllers.controller("NavController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry',
  ($scope,$routeParams,$location,$resource,$event,Project,Simulation,Geometry)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/nav_module.html" }

    $scope.addSim = (project) ->
      sim = Simulation.create({ name: "Simulation Name", description: "Description", editing: true, status: "queued", project_id: $scope.activeProject.id})
      $location.path("projects/"+$scope.activeProject.id+"/simulations/"+sim.id)

    $scope.addGeo = (project) ->
      geo = Geometry.create({ name: "Geometry Name", description: "Description", editing: true, project_id: $scope.activeProject.id})
      $location.path("projects/"+$scope.activeProject.id+"/geometries/"+geo.id)

    $scope.addProject = ->
      angular.forEach($scope.projects, (value, key) ->
        value.editing = false
      )
      proj = Project.create({ name: "Name", description: "Description", editing: true})
      $location.path("projects/")

    $scope.editProject = (project) ->
      angular.forEach($scope.projects, (value, key) ->
        value.editing = false
      )
      project.editing = true
      $location.path("projects")

    $scope.openMenu = ($event) ->
      menuLeft = document.getElementById('cbp-spmenu-s1')
      classie.toggle($event.target, 'active')
      classie.toggle(menuLeft, 'cbp-spmenu-open')

    $scope.closeMenu = ($event) ->
      menuLeft = document.getElementById('cbp-spmenu-s1')
      classie.toggle($event.target, 'active')
      classie.toggle(menuLeft, 'cbp-spmenu-open')

])
