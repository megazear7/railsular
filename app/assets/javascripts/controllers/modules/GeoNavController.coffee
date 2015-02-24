controllers = angular.module('controllers')
controllers.controller("GeoNavController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry',
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry)->
    $scope.title = "Geo Nav"
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/geo_nav.html" }

    $scope.addGeometry = ->
      geo = Geometry.create(
        {
          name: "Name"
          description: "Description"
          editing: true
          project_id: $scope.activeProject.id
        }
      )
      $location.path("projects/"+$scope.activeProject.id+"/geometries/"+geo.id)
])
