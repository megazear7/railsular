angular.module('simapp').directive('saDygraph', ->
  {
    scope: {
      file: '='
      id: '='
    }
    controller: ['$scope', '$http', ($scope, $http) ->
      new Dygraph(document.getElementById($scope.id), file)
    ]
    restrict: 'E',
    template: '
      <div id="{{id}}" style="width: 100%; height: 100%; margin: auto;"></div>
      <button id="{{id}}-reset-zoom">Reset Zoom</button>
    '
  }
)
