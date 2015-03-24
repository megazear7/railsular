controllers = angular.module('controllers')
controllers.controller("GeometriesController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry)->
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.projects = Project.all()
    $scope.activeProject = $scope.projects[$routeParams.project_id]
    $scope.geometries = $scope.activeProject.geometries()
    $scope.geometry = $scope.geometries[$routeParams.geometry_id]
])
