angular.module('simapp').directive('saJsonHuman', ->
  {
    scope: {
      json: '='
    }
    controller: ['$scope', '$http', ($scope, $http) ->
      node = JsonHuman.format($scope.json)
      document.getElementById("json-human-test").appendChild(node)
    ]
    restrict: 'E',
    template: '
      <div id="json-human-test"></div>
    '
  }
)
