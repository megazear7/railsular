angular.module('simapp').factory('DataCache', ($http) ->
  {
    assigned_geometries: { }
    geometry_types: { }
    projects: { }
    simulations: { }
    geometries: { }
    results: { }
  }
)
