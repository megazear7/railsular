controllers = angular.module('controllers')
controllers.controller("HelpController", [ '$scope', '$routeParams', '$location', '$resource'
  ($scope,$routeParams,$location,$resource)->
    $scope.template = { url: "modules/admin/help.html" }

    $scope.showingHelp = false

    $scope.toggleHelp = ->
      $scope.showingHelp = !$scope.showingHelp
])
