angular.module('simapp').factory('App', (DataCache,$http,ModelFactory,ObjectFactory) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (app) ->
    # Add the standard object methods
    ObjectFactory("apps", app, [], "admin/")

    # Add the custom object methods
    # None

  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("apps", addMethods, "admin/")

  # create the custom model methods
  # None

  # Create the promises for loading data
  modelMethods["promise"] = $http.get('admin/apps')
    .success (data) ->
      angular.forEach data.apps, (app) ->
        DataCache.apps[app.id] = app
        DataCache.apps[app.id].editing = false
      angular.forEach DataCache.apps, (app, app_id) ->
        addMethods(app)
    .error (data) ->
      console.log('error loading apps')

  # Return the model methods
  modelMethods
)
.run()
