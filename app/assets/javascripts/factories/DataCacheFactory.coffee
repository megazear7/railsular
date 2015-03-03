angular.module('receta').factory('DataCache', ($http) ->
  {
    assigned_geometries: { }
    geometry_types:
      {
        inlet:
          {
            name: "inlet"
            attributes: ["vx", "vy", "vz"]
          }
        outlet:
          {
            name: "outlet"
            attributes: []
          }
        wall:
          {
            name: "wall"
            attributes: []
          }
      }
    projects: { }
    simulations: { }
    geometries: { }
  }
)
