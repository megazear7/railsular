angular.module('simapp').directive('saReporter', ->
  {
    scope: {
      reports: '='
      type: '='
      id: '='
      show: '='
    }
    controller: ['$scope', 'Report', ($scope, Report) ->
      $scope.close = ->
        $scope.show = false

      $scope.send = (reportMessage) ->
        Report.create({message: $scope.reportMessage, reportable_type: $scope.type, reportable_id: $scope.id})
        $scope.show = false
    ]
    restrict: 'E',
    templateUrl: 'directives/reporter.html'
  }
)
