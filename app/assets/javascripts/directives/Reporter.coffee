angular.module('simapp').directive('saReporter', ->
  {
    scope: {
      reportable: '='
      type: '='
      show: '='
    }
    controller: ['$scope', 'Report', ($scope, Report) ->
      $scope.close = ->
        $scope.show.val = false

      $scope.send = (reportMessage) ->
        Report.create({message: $scope.reportMessage, reportable_type: $scope.type, reportable_id: $scope.reportable.id})
        $scope.reportMessage = ""
        $scope.show.val = false
    ]
    restrict: 'E',
    templateUrl: 'directives/reporter.html'
  }
)
