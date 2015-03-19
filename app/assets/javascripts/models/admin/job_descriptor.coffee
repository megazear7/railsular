angular.module('simapp').factory('JobDescriptor', (AdminDataCache,$http,ModelFactory,ObjectFactory) ->

  # create the "object methods". These are methods that get called on a single object (i.e. table row)
  addMethods = (job_descriptor) ->
    # Add the standard object methods
    ObjectFactory("job_descriptors", job_descriptor, [], AdminDataCache, "admin/")

    # Add the custom object methods
    # None

  # create the "model methods". These are methods that get called on the entire model (i.e. an entire table)
  modelMethods = ModelFactory("job_descriptors", addMethods, AdminDataCache, "admin/")

  # create the custom model methods
  modelMethods.geometry_job_descriptors = ->
    ret = {}
    angular.forEach AdminDataCache.job_descriptors, (job_desc, id) ->
      if job_desc.job_type == "geometry"
        ret[job_desc.id] = job_desc
    ret

  modelMethods.simulation_job_descriptors = ->
    ret = {}
    angular.forEach AdminDataCache.job_descriptors, (job_desc, id) ->
      if job_desc.job_type == "simulation"
        ret[job_desc.id] = job_desc
    ret

  # Create the promises for loading data
  modelMethods["promise"] = $http.get('admin/job_descriptors')
    .success (data) ->
      angular.forEach data.job_descriptors, (job_descriptor) ->
        AdminDataCache.job_descriptors[job_descriptor.id] = job_descriptor
        AdminDataCache.job_descriptors[job_descriptor.id].editing = false
      angular.forEach AdminDataCache.job_descriptors, (job_descriptor, job_descriptor_id) ->
        addMethods(job_descriptor)
    .error (data) ->
      console.log('error loading job descriptors')

  # Return the model methods
  modelMethods
)
.run()
