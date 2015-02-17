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
      console.log(project.simulations[newSimId])
      $location.path("projects/"+$scope.activeProject.id+"/simulations/"+newSimId)

    $scope.addGeo = (project) ->
      # todo query API for new blank simulation and get its id
      newGeoId = 20
      project.geometries[newGeoId] = { name: "", description: "", id: newGeoId }
      console.log(project.geometries[newGeoId])
      $location.path("projects/"+$scope.activeProject.id+"/geometries/"+newGeoId)
])
