controllers = angular.module('controllers')
controllers.controller("SimulationController", [ '$scope', '$routeParams', '$location', '$resource', '$http', 'Project', 'Simulation', 'Geometry', 'AssignedGeometry'
  ($scope,$routeParams,$location,$resource,$http,Project,Simulation,Geometry,AssignedGeometry)->
    $scope.link = (url) -> $location.path("/#{url}")
    $scope.template = { url: "modules/simulation.html" }

    $scope.run = ->
      $scope.simulation.final = true
      $scope.simulation.status = "Queued"
      promise = $scope.simulation.save()
      promise.then ->
        $http.post("simulation/#{$scope.simulation.id}/run")
          .success (data) ->
            console.log(data)
          .error (data) ->
            console.log("error running simulation")

    $scope.duplicate = ->
      # add the normal attributes to the new simulation
      sim = {
        name: $scope.simulation.name
        description: $scope.simulation.description
        project_id: $scope.simulation.project_id
        status: $scope.simulation.status
      }
      # add the simulation attributes to the new simulation
      angular.forEach Simulation.attributes(), (attr_info, attr_name) ->
        sim[attr_name] = $scope.simulation[attr_name]
      # actual create the new simulation
      Simulation.create(sim)
      .then (sim) ->
        # duplicate each assigned geometry in similiar fashion
        angular.forEach $scope.simulation.assigned_geometries(), (assigned_geo) ->
          new_assigned_geo = {
            simulation_id: sim.id
            geometry_id: assigned_geo.geometry_id
          }
          angular.forEach Geometry.geo_types()[assigned_geo.geometry().geo_type].assigned_attributes, (attr_info, attr_name) ->
            new_assigned_geo[attr_name] = assigned_geo[attr_name]
          AssignedGeometry.create(new_assigned_geo)
        sim.startEdit()
        $location.path("projects/"+$scope.activeProject.id+"/simulations/"+sim.id)

    $scope.delete = ->
      $scope.simulation.delete()
      $location.path("projects/"+$scope.activeProject.id+"/simulations/")

    $scope.report = ->
      alert("Reporting Simulation...")

    $scope.startEdit = ->
      $scope.simulation.startEdit()
      angular.forEach $scope.simulation.geometries(), (geometry, geo_id) ->
        geometry.startEdit()
      angular.forEach $scope.simulation.assigned_geometries(), (assigned_geometry, id) ->
        assigned_geometry.startEdit()

    $scope.stopEdit = ->
      $scope.simulation.stopEdit()
      angular.forEach $scope.simulation.geometries(), (geometry, geo_id) ->
        geometry.stopEdit()
      angular.forEach $scope.simulation.assigned_geometries(), (assigned_geometry, id) ->
        assigned_geometry.stopEdit()
])
