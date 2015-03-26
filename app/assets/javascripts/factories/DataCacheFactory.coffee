angular.module('simapp').factory('DataCache', ($http) ->
  {
    assigned_geometries: { }
    geometry_types_overview: { }
    projects: { }
    simulations: { }
    geometries: { }
    results: { }
  }
)
