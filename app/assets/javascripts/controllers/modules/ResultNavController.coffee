controllers = angular.module('controllers')
controllers.controller("ResultNavController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry,Result)->
    $scope.template = { url: "modules/result_nav.html" }

    $scope.result = Result.find()

    $scope.current = ->
      $location.path().slice($location.path().lastIndexOf("/")+1)

    $scope.addResult = ->
      Result.create()
        .then (result) ->
          console.log(result)

])
