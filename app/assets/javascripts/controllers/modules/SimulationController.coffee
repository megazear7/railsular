controllers = angular.module('controllers')
controllers.controller("SimulationController", [ '$scope', '$routeParams', '$location', '$resource', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry'
  ($scope,$routeParams,$location,$resource,Project,Simulation,Geometry,AssignedGeometry)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/simulation.html" }

    addingGeometry = { }
    angular.forEach(Geometry.types(), (type, name) ->
      addingGeometry[name] = false
    )

    $scope.addingGeometry = (type) ->
      addingGeometry[type]

    $scope.geometry_types = Geometry.types()

    $scope.run = ->
      alert("run")

    $scope.duplicate = ->
      sim = Simulation.create(
        {
          name: $scope.simulation.name
          description: $scope.simulation.description
          editing: true
          project_id: $scope.simulation.project_id
          status: $scope.simulation.status
          measurement_scale: $scope.simulation.measurement_scale
          fluid_type: $scope.simulation.fluid_type
          kinematic_viscosity: $scope.simulation.kinematic_viscosity
          density: $scope.simulation.density
          steps: $scope.simulation.steps
        }
      )
      $location.path("projects/"+$scope.activeProject.id+"/simulations/"+sim.id)

    $scope.delete = ->
      $scope.simulation.delete()
      $location.path("projects/"+$scope.activeProject.id+"/simulations/")

    $scope.report = ->
      alert("Reporting Simulation...")

    $scope.startEdit = ->
      $scope.simulation.startEdit()
      angular.forEach($scope.simulation.geometries(), (geometry, geo_id) ->
        geometry.startEdit()
      )

    $scope.stopEdit = ->
      $scope.simulation.stopEdit()
      angular.forEach($scope.simulation.geometries(), (geometry, geo_id) ->
        geometry.stopEdit()
      )
      angular.forEach(addingGeometry, (val, id) ->
        addingGeometry[id] = false
      )

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

    $scope.addGeometry = (geo) ->
      geo.editing = true
      attrs = { }
      angular.forEach(Geometry.types()[geo.type].attributes, (attr) ->
        attrs[attr] = 0
      )
      $scope.simulation.addGeometry(geo.id, attrs)
])
