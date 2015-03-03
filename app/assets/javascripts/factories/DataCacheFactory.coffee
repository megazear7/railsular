angular.module('receta').factory('DataCache', ($http) ->
  appData = {
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


  $http.get('/projects')
    .success (data, status, headers, config) ->
      angular.forEach(data.projects, (project) ->
        appData.projects[project.id] = project
      )
    .error (data, status, headers, config) ->
      console.log('error loading projects')

   $http.get('/simulations')
    .success (data, status, headers, config) ->
      angular.forEach(data.simulations, (simulation) ->
        appData.simulations[simulation.id] = simulation
      )
    .error (data, status, headers, config) ->
      console.log('error loading simulations')
 
   $http.get('/geometries')
    .success (data, status, headers, config) ->
      angular.forEach(data.geometries, (geometry) ->
        appData.geometries[geometry.id] = geometry
      )
    .error (data, status, headers, config) ->
      console.log('error loading geometries')

   $http.get('/assigned_geo')
    .success (data, status, headers, config) ->
      angular.forEach(data.assigned_geos, (assigned_geo) ->
        appData.assigned_geometries[assigned_geo.id] = assigned_geo
      )
    .error (data, status, headers, config) ->
      console.log('error loading assigned_geos')
 
     

  appData
)
