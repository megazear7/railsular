controllers = angular.module('controllers')
controllers.controller("GeoNavController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry',
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/geo_nav.html" }

    $scope.addingGeometry = false

    $scope.geometry_types = Geometry.geo_types()

    $scope.startAddingGeometry = ->
      $scope.addingGeometry = true

    $scope.stopAddingGeometry = ->
      $scope.addingGeometry = false

    $scope.addGeometry = (geo_type) ->
      $scope.addingGeometry = false
      geo = Geometry.create(
        {
          name: "Name"
          geo_type: geo_type
          description: "Description"
          editing: true
          project_id: $scope.activeProject.id
        }
      )
      $location.path("projects/"+$scope.activeProject.id+"/geometries/"+geo.id)
])
