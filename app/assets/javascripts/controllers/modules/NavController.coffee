controllers = angular.module('controllers')
controllers.controller("NavController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', '$http'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,$http,$event)->
    $scope.template = { url: "modules/nav.html" }

    $scope.app_name = ""
    $http.get('admin/data/show')
      .success (data) ->
        $scope.app_name = data.name

    $scope.addSim = (project) ->
      promise = Simulation.create({ name: "Simulation Name", description: "Description", status: "queued", project_id: $scope.activeProject.id})
      promise.then (sim) ->
        sim.startEdit()
        $location.path("projects/"+$scope.activeProject.id+"/simulations/"+sim.id)

    $scope.addGeo = (project) ->
      promise = Geometry.create({ name: "Geometry Name", description: "Description", project_id: $scope.activeProject.id})
      promise.then (geo) ->
        $location.path("projects/"+$scope.activeProject.id+"/geometries/"+geo.id)

    $scope.addProject = ->
      angular.forEach $scope.projects, (value, key) ->
        value.stopEdit()
      promise = Project.create({name: "Name", description: "Description"})
      promise.then (project) ->
        project.startEdit()
        $location.path("projects/")

    $scope.editProject = (project) ->
      angular.forEach $scope.projects, (value, key) ->
        value.editing = false
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
