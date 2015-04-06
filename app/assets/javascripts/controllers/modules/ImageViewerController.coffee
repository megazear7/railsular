controllers = angular.module('controllers')
controllers.controller("ImageViewerController", [ '$scope', '$routeParams', '$location', '$resource', '$http', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result', 'App'
  ($scope,$routeParams,$location,$resource,$http,Project,Simulation,Geometry,AssignedGeometry,Result,App)->
    $scope.template = { url: "modules/image_viewer.html" }
])
