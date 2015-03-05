controllers = angular.module('controllers')
controllers.controller("AssignedGeometriesController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/assigned_geometries.html" }

    $scope.geometry_types = Geometry.geo_types()

    addingGeometry = { }
    angular.forEach(Geometry.geo_types(), (geo_type, name) ->
      addingGeometry[name] = false
    )

    $scope.addingGeometry = (geo_type) ->
      addingGeometry[geo_type]

    $scope.geometryByType = (geo_type) ->
      geos = Geometry.allByType(geo_type)
      angular.forEach($scope.simulation.geometries(), (val, id) ->
        if id of geos
          delete geos[id]
      )
      geos

    $scope.startAddingGeometry = (geo_type) ->
      addingGeometry[geo_type] = true

    $scope.stopAddingGeometry = (geo_type) ->
      addingGeometry[geo_type] = false

    $scope.removeGeometry = (geo) ->
      geo.stopEdit()
      assigned_geo = AssignedGeometry.find_by(geometry_id: geo.id, simulation_id: $scope.simulation.id)
      if assigned_geo
        assigned_geo.delete()

    $scope.$watch(
      (scope) ->
        scope.simulation.editing
      (newVal, oldVal) ->
        if newVal == false
          angular.forEach(addingGeometry, (val, name) ->
            $scope.stopAddingGeometry(name)
          )
    )

    $scope.addGeometry = (geo) ->
      attrs = { }
      angular.forEach(Geometry.geo_types()[geo.geo_type].attributes, (attr) ->
        attrs[attr] = 0
      )
      promise = $scope.simulation.addGeometry(geo.id, attrs)
      promise.then (assigned_geo) ->
        assigned_geo.startEdit()
])
