controllers = angular.module('controllers')
controllers.controller("ImageViewerController", [ '$scope', '$routeParams', '$location', '$resource', '$http', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result', 'App'
  ($scope,$routeParams,$location,$resource,$http,Project,Simulation,Geometry,AssignedGeometry,Result,App)->
    $scope.template = { url: "modules/image_viewer.html" }

    $scope.sim1 = Simulation.find(41)
    
    $scope.baseUrl = "/awesim_dev/rails3/simapp/simulation/<<id>>/image?variable_name=<<variable_name>>&component_direction=<<component_direction>>&view=<<view>>"

    $scope.urls = [
      {
        url: "/awesim_dev/rails3/simapp/simulation/<<id>>/image?variable_name=<<variable_name>>&component_direction=<<component_direction>>&view=<<view>>"
        sim: { }
      }
      {
        url: ""
        sim: { }
      }
      {
        url: ""
        sim: { }
      }
      {
        url: ""
        sim: { }
      }
    ]

    $scope.control = {
      variable_name: ""
      component_direction: ""
      view: ""
    }

    $scope.refresh = ->
      console.log($scope.urls)
      for i in [0, 1, 2, 3]
        if $scope.selectedSimulationIds[i]
          $scope.urls[i].url = $scope.baseUrl.replace("<<id>>", $scope.selectedSimulationIds[i])
            .replace("<<variable_name>>", $scope.control.variable_name)
            .replace("<<component_direction>>", $scope.control.component_direction)
            .replace("<<view>>", $scope.control.view)
          $scope.urls[i].sim = Simulation.find($scope.selectedSimulationIds[i])
        else
          $scope.urls[i].url = ""
          $scope.urls[i].sim = { }
      console.log($scope.urls)
])
