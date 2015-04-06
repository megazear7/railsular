controllers = angular.module('controllers')
controllers.controller("ResultsController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'Result'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,Result)->
    $scope.link = (url) -> $location.path("/#{url}")

    $scope.projects = Project.all()
    $scope.activeProject = $scope.projects[$routeParams.project_id]
    $scope.results = Result.all()
    $scope.simulations = $scope.activeProject.simulations_where(status: "Complete")

    $scope.resultType = { val: 'curves' }

    if $routeParams.result_id and !isNaN($routeParams.result_id)
      $scope.result = Result.find($routeParams.result_id)
      $scope.showResult = true
    else
      $scope.showResult = false

    $scope.selectedSimulationIds = [ ]

    $scope.isSelected = (sim) ->
      return sim.id in $scope.selectedSimulationIds

    $scope.removeSimulation = (sim) ->
      index = $scope.selectedSimulationIds.indexOf(sim.id)
      if (index > -1)
        $scope.selectedSimulationIds.splice(index, 1)

    $scope.addSimulation = (sim) ->
      $scope.selectedSimulationIds.push(sim.id)

    $scope.addOrRemoveSimulation = (sim) ->
      if $scope.isSelected(sim)
        $scope.removeSimulation(sim)
      else
        $scope.addSimulation(sim)

    $scope.btnType = (sim) ->
      if $scope.isSelected(sim)
        "primary"
      else
        "default"
])
