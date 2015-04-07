controllers = angular.module('controllers')
controllers.controller("ImageViewerController", [ '$scope', '$routeParams', '$location', '$resource', '$http', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result', 'App', 'ImageData'
  ($scope,$routeParams,$location,$resource,$http,Project,Simulation,Geometry,AssignedGeometry,Result,App,ImageData)->
    $scope.template = { url: "modules/image_viewer.html" }

    $scope.sim1 = Simulation.find(41)
    baseUrl = "/awesim_dev/rails3/simapp/simulation/<<id>>/image?variable_name=<<variable_name>>&component_direction=<<component_direction>>&view=<<view>>"
    $scope.urls = [
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
      {
        url: ""
        sim: { }
      }
    ]
    $scope.control = {
      variableName: ""
      componentDirection: ""
      view: ""
    }

    $scope.$watchCollection 'selectedSimulationIds', ->
      $scope.refresh()

    $scope.refresh = ->
      for i in [0, 1, 2, 3]
        if $scope.selectedSimulationIds[i]
          $scope.urls[i].url = baseUrl.replace("<<id>>", $scope.selectedSimulationIds[i])
            .replace("<<variable_name>>", $scope.control.variableName)
            .replace("<<component_direction>>", $scope.control.componentDirection)
            .replace("<<view>>", $scope.control.view)
          $scope.urls[i].sim = Simulation.find($scope.selectedSimulationIds[i])
        else
          $scope.urls[i].url = ""
          $scope.urls[i].sim = { }

    $scope.variableNames = ImageData.variableNames()
    $scope.componentDirections = [""]
    $scope.views = [""]

    $scope.updateComponentDirections = (variableName) ->
      $scope.componentDirections = ImageData.componentDirections(variableName)
      $scope.control.variableName = variableName
      if $scope.control.componentDirection != ""
        $scope.updateViews(variableName, $scope.control.componentDirection)

    $scope.updateViews = (variableName, componentDirection) ->
      $scope.views = ImageData.views(variableName, componentDirection)
      $scope.control.componentDirection = componentDirection
      $scope.refresh()

    $scope.updateView = (view) ->
      $scope.control.view = view
      $scope.refresh()
])
