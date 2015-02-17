controllers = angular.module('controllers')
controllers.controller("ProjectsController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.title = "Projects"
    $scope.message = "Hello this is the projects controller"
    $scope.link = (url) -> $location.path("/#{url}")

    # the projects controller simply lists the projects and lets you select one (which takes you to the simulations controller)

    importProjects = ->
      [
        { name: "Project 1", description: "stuff", id: 1},
        { name: "Test Project", description: "my stuff again", id: 2},
        { name: "Project AAA", description: "yet another project", id: 3},
        { name: "Project Blah", description: "blah blah", id: 5}
      ]

    $scope.projects = importProjects()
])
