controllers = angular.module('controllers')
controllers.controller("NavBarController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'App'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,App)->
    $scope.template = { url: "modules/nav_bar.html" }

    $scope.appName = App.find(1).name
])
