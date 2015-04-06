controllers = angular.module('controllers')
controllers.controller("MovieViewerController", [ '$scope', '$routeParams', '$location', '$resource', '$http', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result', 'App'
  ($scope,$routeParams,$location,$resource,$http,Project,Simulation,Geometry,AssignedGeometry,Result,App)->
    $scope.template = { url: "modules/movie_viewer.html" }
])
