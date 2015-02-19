controllers = angular.module('controllers')
controllers.controller("GeometriesController", [ '$scope', '$routeParams', '$location', '$resource', 'ProjectService', 'DataProvider',
  ($scope,$routeParams,$location,$resource,ProjectService,DataProvider)->
    $scope.title = "Geometries"
    $scope.message = "Hello this is the geometries controller"
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.projects = ProjectService
    $scope.activeProject = $scope.projects[$routeParams.project_id]

    $scope.geometries = $scope.activeProject.geometries

    if $routeParams.geometry_id
      $scope.geometry = $scope.geometries[$routeParams.geometry_id]
      $scope.geoSelected = { selected: true, message: "Geo already selected" }
    else
      $scope.geoSelected = { selected: false, message: "Select a geometry on the left" }

    # $routeParams.project_id must be set. Display the simulation tree for the given project on the left and 
    # project details on the right. If a geometry is selected display its details on the right instead of project
    # details. If the root project node is selected display the project details again. If the simulations tab above the 
    # tree is selected then navigate to /projects/:project_id/simulations
])
