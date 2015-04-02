angular.module('simapp').directive('saDygraph', ->
  {
    scope: {
      url: '='
      chartname: '='
      params: '='
    }
    controller: ['$scope', '$http', '$timeout', ($scope, $http, $timeout) ->
      $scope.params = {} if $scope.params == null
      $http.get($scope.url,params: $scope.params )
        .success (data) ->
          graph = new Dygraph(document.getElementById($scope.chartname+"-chart"), data,
          {
            highlightSeriesOpts: {
              showRangeSelector: true # this is not working for some reason
              strokeWidth: 2
              strokeBorderWidth: 1
              hightlightCirclesSize: 5
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
