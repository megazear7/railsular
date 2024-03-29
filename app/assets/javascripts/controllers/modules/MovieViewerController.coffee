controllers = angular.module('controllers')
controllers.controller("MovieViewerController", [ '$scope', '$routeParams', '$location', '$resource', '$http', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry', 'Result', 'App', 'MovieData', '$interval'
  ($scope,$routeParams,$location,$resource,$http,Project,Simulation,Geometry,AssignedGeometry,Result,App,MovieData,$interval)->
    $scope.template = { url: "modules/movie_viewer.html" }

    baseUrl = "simulation/<<id>>/movie_frame?slice_normal=<<slice_normal>>&variable_name=<<variable_name>>&component_direction=<<component_direction>>&frame=<<frame>>"

    $scope.urls = [
      {
        urls: []
        sim: { }
      }
      {
        urls: []
        sim: { }
      }
      {
        urls: []
        sim: { }
      }
      {
        urls: []
        sim: { }
      }
    ]

    $scope.control = {
      sliceNormal: ""
      variableName: ""
      componentDirection: ""
      frame: 1
      frameCount: 1
      playspeed: 100
      updating: false
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
      if $scope.control.sliceNormal != "" and $scope.control.variableName != "" and $scope.control.componentDirection != ""
        $scope.stop()
        $scope.control.updating = true
        MovieData.frameCount($scope.selectedSimulationIds, $scope.control.sliceNormal, $scope.control.variableName, $scope.control.componentDirection).then (frameCount) ->
          $scope.control.frameCount = frameCount
          for i in [0, 1, 2, 3]
            if $scope.selectedSimulationIds[i]
              for frame in [1..$scope.control.frameCount]
                $scope.urls[i].urls[frame] = baseUrl.replace("<<id>>", $scope.selectedSimulationIds[i])
                  .replace("<<slice_normal>>", $scope.control.sliceNormal)
                  .replace("<<variable_name>>", $scope.control.variableName)
                  .replace("<<component_direction>>", $scope.control.componentDirection)
                  .replace("<<frame>>", frame)
              $scope.urls[i].sim = Simulation.find($scope.selectedSimulationIds[i])
            else
              $scope.urls[i].urls = []
              $scope.urls[i].sim = { }
          # this interval here cycles through all of the images and loades them in so that they get cached by the browser. The images
          # are hidden during this time because control.updating is true. In this way the user doesn't see the images flashing.
          $interval($scope.nextFrame, 100, $scope.control.frameCount)
            .then ->
              $scope.control.frame = 1
              $scope.control.updating = false

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

    $scope.stop = ->
      $scope.control.frame = 1

    $scope.fastBack = ->
      $scope.control.frame = 1

    $scope.fastForward = ->
      $scope.control.frame = $scope.control.frameCount

    $scope.nextFrame = ->
      $scope.control.frame = $scope.control.frame + 1
      if $scope.control.frame > $scope.control.frameCount
        $scope.control.frame = 1

    $scope.previousFrame = ->
      $scope.control.frame = $scope.control.frame - 1
      if $scope.control.frame < 1
        $scope.control.frame = $scope.control.frameCount

    $scope.playOnRepeat = ->
      promise = $interval($scope.nextFrame, $scope.control.playspeed)
      $scope.pause = ->
        $interval.cancel(promise)
      $scope.stop = ->
        $interval.cancel(promise)
        $scope.control.frame = 1

    $scope.play = ->
      promise = $interval($scope.nextFrame, $scope.control.playspeed, $scope.control.frameCount-1)
      $scope.pause = ->
        $interval.cancel(promise)
      $scope.stop = ->
        $interval.cancel(promise)
        $scope.control.frame = 1

    $scope.range = (min, max) ->
      input = []
      for i in [min..max]
        input.push(i)
      input
])
