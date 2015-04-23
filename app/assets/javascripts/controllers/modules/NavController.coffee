controllers = angular.module('controllers')
controllers.controller("NavController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'App'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,App)->
    $scope.template = { url: "modules/nav.html" }

    $scope.openMenu = ->
      menuLeft = document.getElementById('cbp-spmenu-s1')
      classie.add(menuLeft, 'cbp-spmenu-open')

    $scope.closeMenu = ->
      menuLeft = document.getElementById('cbp-spmenu-s1')
      classie.remove(menuLeft, 'cbp-spmenu-open')
])
