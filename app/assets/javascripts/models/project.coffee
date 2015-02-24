angular.module('receta').factory('Project', (DataCache) ->
  addMethods = (project) ->

    project.save = ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      console.log("not yet implemented")

    project.delete = ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      delete DataCache.projects[project.id]

    project.simulations = ->
      simList = {}
      angular.forEach(DataCache.simulations, (simulation, sim_id) ->
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
      angular.forEach(DataCache.geometries, (geometry, geo_id) ->
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

  angular.forEach(DataCache.projects, (project, proj_id) ->
    addMethods(project)
  )

  {
    all: ->
      DataCache.projects
    find: (id) ->
      DataCache.projects[id]
    create: (project) ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      project.id = 20
      DataCache.projects[project.id] = project
      addMethods(project)
      DataCache.projects[project.id]
  }
)
.run( (Project) -> console.log('Project service is ready') )
