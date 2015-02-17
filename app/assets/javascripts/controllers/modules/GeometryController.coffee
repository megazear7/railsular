controllers = angular.module('controllers')
controllers.controller("GeometryController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.title = "Geometry"
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/geometry.html" }

    # the responsibility of this controller is to manage a single given geometry.
    # this controller expects $scope.geometry to be set to a geometry json object or
    # to be set to a json object of the following form:
    # { geometryNotSet: true, message: "some message..." }
    # in which case the message will appear in lieu of a geometry
])
