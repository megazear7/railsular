controllers = angular.module('controllers')
controllers.controller("ProjectsController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'DataCache'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,DataCache)->
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.projects = Project.all()
])
