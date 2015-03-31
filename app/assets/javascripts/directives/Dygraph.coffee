angular.module('simapp').directive('saDygraph', ->
  {
    scope: {
      file: '='
      chartname: '='
    }
    controller: ['$scope', '$http', '$timeout', ($scope, $http, $timeout) ->
      $http.get($scope.file)
        .success (data) ->
          graph = new Dygraph(document.getElementById($scope.chartname+"-chart"), data,
          {
            highlightSeriesOpts: {
              customBars: true
              strokeWidth: 2
              strokeBorderWidth: 1
              hightlightCirclesSize: 5
              showRangeSelector: true
            }
          })
          $('#'+$scope.chartname+'-reset-zoom').click ->
            graph.resetZoom()
    ]
    restrict: 'E',
    template: '
      <div id="{{chartname}}-chart" style="width: 100%; height: 500px; margin: auto;"></div>
      <button id="{{chartname}}-reset-zoom">Reset Zoom</button>
    '
  }
)
