angular.module('receta').factory('Project', (DataCache,ModelFactory,ObjectFactory,$http) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (project) ->
    # Add the standard object methods
    ObjectFactory("projects", project)

    # Add the custom object methods
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

    project.geometriesByType = (geo_type) ->
      geoList = {}
      angular.forEach(project.geometries(), (geometry, id) ->
        if geometry.geo_type == geo_type
          geoList[id] = geometry
      )
      geoList

    project.geometry = (id) ->
      geos = project.geometries()
      if geos[id]
        geos[id]
      else
        "Project with id #{project.id} does not have a geometry with id #{id}"

  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("projects", addMethods)

  # create the custom model methods
  # None

  # Create the promises for loading data
  modelMethods["promise"] = $http.get('/projects')
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

  # Return the model methods
  modelMethods
)
.run( (Project) -> console.log('Project service is ready') )
