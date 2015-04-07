controllers = angular.module('controllers')
controllers.controller("MovieViewerController", [ '$scope', '$routeParams', '$location', '$resource', '$http', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result', 'App', 'MovieData'
  ($scope,$routeParams,$location,$resource,$http,Project,Simulation,Geometry,AssignedGeometry,Result,App,MovieData)->
    $scope.template = { url: "modules/movie_viewer.html" }

    baseUrl = "/awesim_dev/rails3/simapp/simulation/<<id>>/movie_frame?slice_normal=<<slice_normal>>&variable_name=<<variable_name>>&component_direction=<<component_direction>>&frame=<<frame>>"
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
      sliceNormal: ""
      variableName: ""
      componentDirection: ""
      frame: 0
    }

    $scope.$watchCollection 'selectedSimulationIds', ->
      if $scope.selectedSimulationIds.length > 0
        MovieData.sliceNormals($scope.selectedSimulationIds).then (sliceNormals) ->
          $scope.sliceNormals = sliceNormals
        if $scope.control.sliceNormal != ""
          MovieData.variableNames($scope.selectedSimulationIds, $scope.sliceNormal).then (variableNames) ->
            $scope.variableNames = variableNames
        if $scope.control.sliceNormal != "" and $scope.control.variableName != ""
          MovieData.componentDirections($scope.selectedSimulationIds, $scope.sliceNormal, $scope.control.variableName).then (componentDirections) ->
            $scope.componentDirections = componentDirections
        $scope.refresh()

    $scope.refresh = ->
      for i in [0, 1, 2, 3]
        if $scope.selectedSimulationIds[i]
          $scope.urls[i].url = baseUrl.replace("<<id>>", $scope.selectedSimulationIds[i])
            .replace("<<slice_normal>>", $scope.control.sliceNormal)
            .replace("<<variable_name>>", $scope.control.variableName)
            .replace("<<component_direction>>", $scope.control.componentDirection)
            .replace("<<frame>>", 1)
          $scope.urls[i].sim = Simulation.find($scope.selectedSimulationIds[i])
        else
          $scope.urls[i].url = ""
          $scope.urls[i].sim = { }

    if $scope.selectedSimulationIds.length > 0
      MovieData.sliceNormals($scope.selectedSimulationIds).then (sliceNormals) ->
        $scope.sliceNormals = sliceNormals

    $scope.variableNames = []
    $scope.componentDirections = []
    $scope.views = []

    $scope.updateVariableNames = (sliceNormal) ->
      MovieData.variableNames($scope.selectedSimulationIds, sliceNormal).then (variableNames) ->
        $scope.variableNames = variableNames
      $scope.control.sliceNormal = sliceNormal
      $scope.refresh()

    $scope.updateComponentDirections = (sliceNormal, variableName) ->
      MovieData.componentDirections($scope.selectedSimulationIds, sliceNormal, variableName).then (componentDirections) ->
        $scope.componentDirections = componentDirections
      $scope.control.variableName = variableName

    $scope.updateComponentDirection = (componentDirection) ->
      $scope.control.componentDirection = componentDirection
      $scope.refresh()
])
