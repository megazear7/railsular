angular.module('receta').factory('Geometry', (DataCache,ModelFactory,$http) ->
  addMethods = (geometry) ->

    geometry.save = ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      console.log("not yet implemented")

    geometry.delete = ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      delete DataCache.geometries[geometry.id]

    geometry.startEdit = ->
      this.editing = true

    geometry.stopEdit = ->
      geometry.save()
      this.editing = false

    geometry.assigned_geos = ->
      assigned_geos = {}
      angular.forEach(DataCache.assigned_geometries, (assigned_geo, id) ->
        if assigned_geo.geometry_id == geometry.id
          assigned_geos[id] = assigned_geo
      )
      assigned_geos

    # this is a custom method for quickly building assigned geometries
    geometry.addSimulation = (sim_id, attr) ->
      # todo use $http to save this to the rails API, in the error callback we might need to revert this change
      new_id = Math.floor((Math.random() * 10000) + 1)
      DataCache.assigned_geometries[new_id] = {id: new_id, simulation_id: sim_id, geometry_id: geometry.id, attributes: attr}

    # this is a custom method, it kind of represents "has_many :simulations, through: assigned_geometries"
    geometry.simulations = ->
      simIds = []
      angular.forEach(DataCache.assigned_geometries, (val, key) ->
        if val.geometry_id == geometry.id
          simIds.push(val.simulation_id)
      )
      simList = {}
      angular.forEach(simIds, (sim_id) ->
        simList[sim_id] = DataCache.simulations[sim_id]
      )
      simList

    geometry.project = ->
      DataCache.projects[geometry.project_id]

    geometry.specificAttributes = (sim_id) ->
      attrs = { }
      angular.forEach(DataCache.assigned_geometries, (assigned_geo, key) ->
        if assigned_geo.geometry_id == geometry.id && assigned_geo.simulation_id == sim_id
          angular.forEach(DataCache.geometry_types[assigned_geo.geometry().geo_type].attributes, (attr_name) ->
            attrs[attr_name] = assigned_geo[attr_name]
          )
      )
      attrs

  #$http.get('/geometries')
  #  .success (data, status, headers, config) ->
  #    angular.forEach(data.geometries, (geometry) ->
  #      DataCache.geometries[geometry.id] = geometry
  #      DataCache.geometries[geometry.id].editing = false
  #    )
  #    angular.forEach(DataCache.geometries, (geometry, geo_id) ->
  #      addMethods(geometry)
  #    )
  #  .error (data, status, headers, config) ->
  #    console.log('error loading geometries')

  angular.forEach(DataCache.geometries, (geometry, geo_id) ->
    addMethods(geometry)
  )

  modelMethods = ModelFactory("geometries", addMethods)

  modelMethods["geo_types"] = ->
    DataCache.geometry_types

  modelMethods["allByType"] = (geo_type) ->
    geoList = {}
    angular.forEach(DataCache.geometries, (val, id) ->
      if val.geo_type == geo_type
        geoList[id] = val
    )
    geoList

  modelMethods
)
.run( (Geometry) -> console.log('Geometry service is ready') )
