angular.module('simapp').factory('Project', (DataCache,ModelFactory,ObjectFactory,$http) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (project) ->
    # Add the standard object methods
    ObjectFactory("projects", project, [{has_many: "geometries"}
                                        {has_many: "simulations"}
                                        {has_many: "reports", as: "reportable"}])

    # Add the custom object methods
    # None

  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("projects", addMethods)

  # create the custom model methods
  # None

  # Create the promises for loading data
  modelMethods["promise"] = $http.get('projects')
    .success (data) ->
      angular.forEach data.projects, (project) ->
        DataCache.projects[project.id] = project
        DataCache.projects[project.id].editing = false
      angular.forEach DataCache.projects, (project, proj_id) ->
        addMethods(project)
    .error (data) ->
      console.log('error loading projects')

  # Return the model methods
  modelMethods
)
.run()
