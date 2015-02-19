receta = angular.module('receta',[
  'templates',
  'ngRoute',
  'ngResource',
  'controllers',
  'angular-flash.service',
  'angular-flash.flash-alert-directive'
])

receta.config([ '$routeProvider', 'flashProvider',
  ($routeProvider,flashProvider)->

    flashProvider.errorClassnames.push("alert-danger")
    flashProvider.warnClassnames.push("alert-warning")
    flashProvider.infoClassnames.push("alert-info")
    flashProvider.successClassnames.push("alert-success")

    $routeProvider
      .when('/',
        templateUrl: "layouts/projects.html"
        controller: 'ProjectsController'
      ).when('/projects',
        templateUrl: "layouts/projects.html"
        controller: 'ProjectsController'
      ).when('/projects/:project_id',
        templateUrl: "layouts/simulations.html"
        controller: 'SimulationsController'
      ).when('/projects/:project_id/simulations/:simulation_id',
        templateUrl: "layouts/simulations.html"
        controller: 'SimulationsController'
      ).when('/projects/:project_id/simulations',
        templateUrl: "layouts/simulations.html"
        controller: 'SimulationsController'
      ).when('/projects/:project_id/geometries/:geometry_id',
        templateUrl: "layouts/geometries.html"
        controller: 'GeometriesController'
      ).when('/projects/:project_id/geometries',
        templateUrl: "layouts/geometries.html"
        controller: 'GeometriesController'
      )
])

# Note A:
# check the cache for a project/simulation/geometry with the given id and check if it is clean or dirty.
# if it is clean use it if it is dirty use $http to update the cache, set the 
# cache entry to clean and then use the cache to return data in this format given below

# Note B:
# check each simulation/geometry in the cache with project_id of this projects id. If it is
# dirty update it with $http and set it to clean. Then use the cache to return all
# of the simulations/geometries for this project in the format given below

receta.factory('DataProvider', (DataCache) ->

  ### Project Object Instance Methods ###
  angular.forEach(DataCache["projects"], (project, proj_id) ->
    project.simulations = ->
      simList = {}
      angular.forEach(DataCache["simulations"], (simulation, sim_id) ->
        if simulation.dirty && simulation.id == project.id
          # todo use $http to update the project
          tmp = "dirty" # need a line here for coffescript to compile
        if simulation.project_id == project.id
          simList[sim_id] = simulation
      )
      simList
    project.simulation = (id) ->
      sims = project.simulations()
      if sims[id]
        if sims[id].dirty
          # todo use $http to update the project
          tmp = "dirty" # need a line here for coffescript to compile
        sims[id]
      else
        "Project with id #{project.id} does not have a simulation with id #{id}"
    project.geometries = ->
      geoList = {}
      angular.forEach(DataCache["geometries"], (geometry, geo_id) ->
        if geometry.dirty && geometry.id == project.id
          # todo use $http to update the project
          tmp = "dirty" # need a line here for coffescript to compile
        if geometry.project_id == project.id
          geoList[geo_id] = geometry
      )
      geoList
    project.geometry = (id) ->
      geos = project.geometries()
      if geos[id]
        if geos[id].dirty
          # todo use $http to update the project
          tmp = "dirty" # need a line here for coffescript to compile
        geos[id]
      else
        "Project with id #{project.id} does not have a geometry with id #{id}"
    project.startEdit = ->
      this.editing = true
    project.stopEdit = ->
      # todo save this to database
      # todo mark cache as dirty
      this.editing = false
  )

  ### Simulation Object Instance Methods ###
  angular.forEach(DataCache["simulations"], (simulation, sim_id) ->
    simulation.startEdit = ->
      this.editing = true
    simulation.stopEdit = ->
      # todo save this to database
      # mark cache as dirty
      this.editing = false
    simulation.geometries = ->
      geoList = {}
      angular.forEach(DataCache["geometries"], (geometry, geo_id) ->
        if geometry.dirty && geometry.id == simulation.id
          # todo use $http to update the project
          tmp = "dirty" # need a line here for coffescript to compile
        if geometry.simulation_id == simulation.id
          geoList[geo_id] = geometry
      )
      geoList
    simulation.geometry = (id) ->
      geos = simulation.geometries()
      if geos[id]
        if geos[id].dirty
          # todo use $http to update the project
          tmp = "dirty" # need a line here for coffescript to compile
        geos[id]
      else
        "Simulation with id #{simulation.id} does not have a geometry with id #{id}"
    simulation.project = ->
      if DataCache["projects"][simulation.project_id].dirty
        # todo use $http to update the project
        tmp = "dirty" # need a line here for coffescript to compile
      DataCache["projects"][simulation.project_id]
  )

  ### Geometry Object Instance Methods ###
  angular.forEach(DataCache["geometries"], (geometry, geo_id) ->
    geometry.startEdit = ->
      this.editing = true
    geometry.stopEdit = ->
      # todo save this to database
      # mark cache as dirty
      this.editing = false
    geometry.simulation = ->
      if DataCache["simulations"][geometry.simulation_id].dirty
        # todo use $http to update the project
        tmp = "dirty" # need a line here for coffescript to compile
      DataCache["simulations"][geometry.simulation_id]
    geometry.project = ->
      if DataCache["projects"][geometry.project_id].dirty
        # todo use $http to update the project
        tmp = "dirty" # need a line here for coffescript to compile
      DataCache["projects"][geometry.project_id]
  )

  ### Functions to return as the DataProvider ###
  {
    projects: ->
      angular.forEach(DataCache["projects"], (project, proj_id) ->
        if project.dirty
          # todo use $http to update the project
          tmp = "dirty" # need a line here for coffescript to compile
      )
      DataCache["projects"]
    project: (id) ->
      if DataCache["projects"][id].dirty
        # todo use $http to update the project
        tmp = "dirty" # need a line here for coffescript to compile
      DataCache["projects"][id]
    simulation: (id) ->
      if DataCache["simulations"][id].dirty
        # todo use $http to update the project
        tmp = "dirty" # need a line here for coffescript to compile
      DataCache["simulations"][id]
    geometry: (id) ->
      if DataCache["geometries"][id].dirty
        # todo use $http to update the project
        tmp = "dirty" # need a line here for coffescript to compile
      DataCache["geometries"][id]
    create:
      {
        project: (proj) ->
          # todo use $http to send proj and receive a new project
          proj.id = 20
          DataCache["projects"][proj.id] = proj
          # todo the project methods need added
          DataCache["projects"][proj.id]
        simulation: (sim) ->
          # todo use $http to send sim and receive a new sim
          sim.id = 20
          DataCache["simulations"][sim.id] = sim
          # todo the simulation methods need added
          DataCache["simulations"][sim.id]
        geometry: (geo) ->
          # todo use $http to send geo and receive a new geo
          geo.id = 20
          DataCache["geometries"][geo.id] = geo
          # todo the project methods need added
          DataCache["geometries"][geo.id]
      }
  }
)

receta.factory('DataCache', ->
  {
    projects:
      {
        1:
          {
            dirty: false
            name: "Test Project"
            id: 1
            description: "test project description"
            editing: false

          }
        2:
          {
            dirty: false
            name: "Project Two"
            id: 2
            description: "test project description"
            editing: false
          }
      }
    simulations:
      {
        1:
          {
            dirty: false
            name: "Test Sim"
            id: 1
            project_id: 1
            description: "blah blaj"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        3:
          {
            dirty: false
            name: "SimB"
            id: 3
            project_id: 1
            description: "blah blah"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        4:
          {
            dirty: false
            name: "AnotherSim"
            id: 4
            project_id: 1
            description: "blah"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        2:
          {
            dirty: false
            name: "TestAgainSim"
            id: 2
            project_id: 2
            description: "blah blaj"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        5:
          {
            dirty: false
            name: "SimCCC"
            id: 5
            project_id: 2
            description: "blah blah"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        6:
          {
            dirty: false
            name: "YetAnotherSim"
            id: 6
            project_id: 2
            description: "blah"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        8:
          {
            dirty: false
            name: "Simulation Test"
            id: 8
            project_id: 2
            description: "blah"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        11:
          {
            dirty: false
            name: "Sim Test"
            id: 11
            project_id: 2
            description: "blah"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
      }
    geometries:
      {
        1:
          {
            dirty: false
            name: "GEO B"
            id: 1
            project_id: 1
            simulation_id: 1
            description: "blah"
            editing: false
            type: "inlet"
            attributes:
              {
                vx: 1.24
                vy: 2.45
                vz: 1.9
              }
          }
        2:
          {
            dirty: false
            name: "Geometry Again"
            id: 2
            project_id: 1
            simulation_id: 1
            description: "blah"
            editing: false
            type: "outlet"
            attributes:
              {
              }
          }
        3:
          {
            dirty: false
            name: "GEO C"
            id: 3
            project_id: 2
            simulation_id: 11
            description: "blah"
            editing: false
            type: "outlet"
            attributes:
              {
              }
          }
        4:
          {
            dirty: false
            name: "Geo Again"
            id: 4
            project_id: 2
            simulation_id: 11
            description: "blah"
            editing: false
            type: "inlet"
            attributes:
              {
                vx: 1.24
                vy: 2.45
                vz: 1.9
              }
          }
      }
  }
)

controllers = angular.module('controllers',[])
