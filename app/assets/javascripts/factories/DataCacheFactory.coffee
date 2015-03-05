angular.module('receta').factory('DataCache', ($http) ->
  {
    assigned_geometries: { }
    geometry_types: { }
    projects: { }
    simulations: { }
    geometries: { }
  }
)
