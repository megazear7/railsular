controllers = angular.module('controllers')
controllers.controller("GeoNavController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry',
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry)->
    $scope.template = { url: "modules/geo_nav.html" }

    $scope.addingGeometry = false

    $scope.geometry_types = Geometry.geo_types()

    $scope.startAddingGeometry = ->
      $scope.addingGeometry = true

    $scope.stopAddingGeometry = ->
      $scope.addingGeometry = false

    $scope.addGeometry = (geo_type_id) ->
      $scope.addingGeometry = false
      promise = Geometry.create(
        {
          geometry_type_id: geo_type_id
          description: ""
          project_id: $scope.activeProject.id
        }
      )
      promise.then (geo) ->
        geo.startEdit()
        $location.path("projects/"+$scope.activeProject.id+"/geometries/"+geo.id)
])
