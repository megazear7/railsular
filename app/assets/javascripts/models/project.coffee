angular.module('receta').factory('Project', (DataCache) ->
  addMethods = (project) ->
    project.save = ->
      # todo use $http to save to rails API
      console.log("not yet implemented")
    project.simulations = ->
      simList = {}
      angular.forEach(DataCache["simulations"], (simulation, sim_id) ->
        if simulation.project_id == project.id
          simList[sim_id] = simulation
      )
      simList
    project.simulation = (id) ->
      sims = project.simulations()
      if sims[id]
        sims[id]
      else
        "Project with id #{project.id} does not have a simulation with id #{id}"
    project.geometries = ->
      geoList = {}
      angular.forEach(DataCache["geometries"], (geometry, geo_id) ->
        if geometry.project_id == project.id
          geoList[geo_id] = geometry
      )
      geoList
    project.geometry = (id) ->
      geos = project.geometries()
      if geos[id]
        geos[id]
      else
        "Project with id #{project.id} does not have a geometry with id #{id}"
    project.startEdit = ->
      this.editing = true
    project.stopEdit = ->
      project.save()
      this.editing = false

  angular.forEach(DataCache["projects"], (project, proj_id) ->
    addMethods(project)
  )

  {
    all: ->
      # todo caching functionality?
      DataCache["projects"]
    find: (id) ->
      # todo caching functionality?
      DataCache["projects"][id]
    create: (project) ->
      # todo use $http to save to rails API
      project.id = 20
      DataCache["projects"][project.id] = project
      addMethods(project)
      DataCache["projects"][project.id]
    addMethods: addMethods
  }
)
