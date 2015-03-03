angular.module('receta').factory('Project', (DataCache,ModelFactory,$http) ->
  addMethods = (project) ->

    project.save = ->
      # todo if there is an error saving the project then revert the project to what the api returns
      $http.post("/project/#{project.id}/update", project)

    project.delete = ->
      # todo, if it comes back that there was an error trying to delete the project then add the project back
      $http.delete("/project/#{project.id}/delete")
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

  $http.get('/projects')
    .success (data, status, headers, config) ->
      angular.forEach(data.projects, (project) ->
        DataCache.projects[project.id] = project
        DataCache.projects[project.id].editing = false
      )
      angular.forEach(DataCache.projects, (project, proj_id) ->
        addMethods(project)
      )
    .error (data, status, headers, config) ->
      console.log('error loading projects')

  ModelFactory("projects", addMethods)
)
.run( (Project) -> console.log('Project service is ready') )
