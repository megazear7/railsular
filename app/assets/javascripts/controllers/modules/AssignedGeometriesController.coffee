controllers = angular.module('controllers')
controllers.controller("AssignedGeometriesController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/assigned_geometries.html" }

    $scope.geometry_types = Geometry.types()

    addingGeometry = { }
    angular.forEach(Geometry.types(), (type, name) ->
      addingGeometry[name] = false
    )

    $scope.addingGeometry = (type) ->
      addingGeometry[type]

    $scope.geometryByType = (type) ->
      geos = Geometry.allByType(type)
      angular.forEach($scope.simulation.geometries(), (val, id) ->
        if id of geos
          delete geos[id]
      )
      geos

    $scope.startAddingGeometry = (type) ->
      addingGeometry[type] = true

    $scope.stopAddingGeometry = (type) ->
      addingGeometry[type] = false

    $scope.removeGeometry = (geo) ->
      geo.editing = false
      assigned_geo = AssignedGeometry.find_by(geometry_id: geo.id, simulation_id: $scope.simulation.id)
      if assigned_geo
        assigned_geo.delete()

    $scope.$watch(
      (scope) ->
        scope.simulation.editing
      (newVal, oldVal) ->
        console.log(oldVal + " ---> " + newVal)
        if newVal == false
          angular.forEach(addingGeometry, (val, name) ->
            $scope.stopAddingGeometry(name)
          )
    )

    $scope.addGeometry = (geo) ->
      geo.editing = true
      attrs = { }
      angular.forEach(Geometry.types()[geo.type].attributes, (attr) ->
        attrs[attr] = 0
      )
      $scope.simulation.addGeometry(geo.id, attrs)
])
