controllers = angular.module('controllers')
controllers.controller("ResultNavController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry,Result)->
    $scope.template = { url: "modules/result_nav.html" }
])
