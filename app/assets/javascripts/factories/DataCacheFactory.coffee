angular.module('receta').factory('DataCache', ($http) ->
  {
    assigned_geometries: { }
    geometry_types:
      {
        inlet:
          {
            name: "inlet"
            attributes: []
            assigned_attributes: ["vx", "vy", "vz"]
          }
        outlet:
          {
            name: "outlet"
            attributes: []
            assigned_attributes: []
          }
        wall:
          {
            name: "wall"
            attributes: []
            assigned_attributes: []
          }
      }
    projects: { }
    simulations: { }
    geometries: { }
  }
)
