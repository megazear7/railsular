controllers = angular.module('controllers')
controllers.controller("TodoModuleController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.template = { url: "modules/todo_module.html" }

    $scope.title = "Todo Module Controller"
    $scope.message = "I am a module-level Angular controller. I am allowed to do client side page navigation, but I cannot expect to be dependent upon any url state information (such as route information or id's and such). That is only available to layout controllers, and I am only a module controller. However, I can be used on any page that wants to plug me in."

    $scope.todos = [ {text: "Clean car"}, {text: "go sky diving"} ]
    $scope.todo = {text:''}

    $scope.addTodo = ->
      $scope.todos.push({text:$scope.todo.text})
      $scope.todo.text = ''
])
