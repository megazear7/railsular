angular.module('receta').factory('ObjectFactory', (DataCache,$http,$q) ->
  (table_name, object, relations) ->
    object.save = ->
      # todo if there is an error saving the object then revert the object to what the api returns
      $http.post("/#{pluralize(table_name, 1)}/#{object.id}/update", object)

    object.delete = ->
      # todo, if it comes back that there was an error trying to delete the object then add the object back
      delete DataCache[table_name][object.id]
      $http.delete("/#{pluralize(table_name, 1)}/#{object.id}/delete")

    object.startEdit = ->
      this.editing = true

    object.stopEdit = ->
      object.save()
      this.editing = false

    angular.forEach(relations, (relation) ->
      if "belongs_to" of relation
        relation = relation.belongs_to
        object[relation] = ->
          DataCache[pluralize(relation)][object["#{relation}_id"]]
      else if "has_many" of relation
        relation = relation.has_many
        object[relation] = ->
          objects = {}
          angular.forEach(DataCache[relation], (obj, id) ->
            if obj["#{pluralize(table_name,1)}_id"] == object.id
              objects[id] = obj
          )
          objects
      else if "has_many_through" of relation
        through = relation.has_many_through.through
        relation = relation.has_many_through.has_many
        object[relation] = ->
          object_ids = []
          angular.forEach(DataCache[through], (val, key) ->
            if val["#{pluralize(table_name,1)}_id"] == object.id
              object_ids.push(val["#{pluralize(relation,1)}_id"])
          )
          object_list = {}
          angular.forEach(object_ids, (object_id) ->
            object_list[object_id] = DataCache[relation][object_id]
          )
          object_list

    )
)



###
    simulation.geometries = ->
      geoIds = []
      angular.forEach(DataCache.assigned_geometries, (val, key) ->
        if val.simulation_id == simulation.id
          geoIds.push(val.geometry_id)
      )
      geoList = {}
      angular.forEach(geoIds, (geo_id) ->
        geoList[geo_id] = DataCache.geometries[geo_id]
      )
      geoList



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


###
