controllers = angular.module('controllers')
controllers.controller("ResultNavController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry,Result)->
    $scope.template = { url: "modules/result_nav.html" }

    $scope.result = Result.find()

    $scope.addResult = ->
      Result.create()
        .then (result) ->
          console.log(result)

    $scope.setResultType = (type) ->
      $scope.resultType.val = type
])
