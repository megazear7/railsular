angular.module('simapp').factory('Report', (DataCache,ModelFactory,ObjectFactory,$http) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (report) ->
    # Add the standard object methods
    ObjectFactory("reports", report, [{belongs_to: "reportable", polymorphic: true}])

    # Add the custom object methods
    # None

  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("reports", addMethods)

  # create the custom model methods
  # None

  # Create the promises for loading data
  modelMethods["promise"] = $http.get('reports')
    .success (data) ->
      angular.forEach data.reports, (report) ->
        DataCache.reports[report.id] = report
        DataCache.reports[report.id].editing = false
      angular.forEach DataCache.reports, (report, proj_id) ->
        addMethods(report)
    .error (data) ->
      console.log('error loading reports')

  # Return the model methods
  modelMethods
)
.run()
