angular.module('simapp').factory('DataCache', ($http) ->
  {
    assigned_geometries: { }
    geometry_types_overview: { }
    projects: { }
    simulations: { }
    geometries: { }
    results: { }
    geometry_types: { }
    attribute_descriptors: { }
    attribute_descriptor_values: { }
    job_descriptors: { }
    apps: { }
    result_vars: { }
    results_simulations: [ ]
  }
)
