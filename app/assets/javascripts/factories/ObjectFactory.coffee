angular.module('simapp').factory 'ObjectFactory', (DataCache,$http,$q) ->
  (table_name, object, relations, cache = DataCache, url_prefix = "") ->
    object.save = ->
      $http.post("#{url_prefix}#{pluralize(table_name, 1)}/#{object.id}/update", object)
        .error (data) ->
          obj = data[pluralize(table_name, 1)]
          angular.forEach Object.keys(obj), (attr) ->
            cache[table_name][obj.id][attr] = obj[attr]

    object.delete = ->
      delete cache[table_name][object.id]
      $http.delete("#{url_prefix}#{pluralize(table_name, 1)}/#{object.id}/delete")
        .error (data) ->
          alert("could not delete #{pluralize(table_name, 1)} due to server error")
          # todo you must change angular routes and come back to the page to see this get added back
          # it should just show up right after the alert
          cache[table_name][object.id] = object

    object.startEdit = ->
      this.editing = true

    object.stopEdit = ->
      object.save()
      this.editing = false

    throughRelation = (relation, through) ->
      object[relation] = ->
        object_ids = []
        angular.forEach cache[through], (val, key) ->
          if val["#{pluralize(table_name,1)}_id"] == object.id
            object_ids.push(val["#{pluralize(relation,1)}_id"])
        object_list = {}
        angular.forEach object_ids, (object_id) ->
          object_list[object_id] = cache[relation][object_id]
        object_list
      object[relation+"_where"] = (attrs) ->
        object_ids = []
        angular.forEach cache[through], (val, key) ->
          if val["#{pluralize(table_name,1)}_id"] == object.id
            object_ids.push(val["#{pluralize(relation,1)}_id"])
        object_list = {}
        angular.forEach object_ids, (object_id) ->
          add_obj_to_objs = true
          angular.forEach attrs, (val, attr) ->
            if cache[relation][object_id][attr] != val
              add_obj_to_objs = false
          if add_obj_to_objs
            object_list[object_id] = cache[relation][object_id]
        object_list

    angular.forEach relations, (relation) ->

      if "belongs_to" of relation
        relation = relation.belongs_to
        object[relation] = ->
          cache[pluralize(relation)][object["#{relation}_id"]]

      else if "has_many" of relation
        relation = relation.has_many
        object[relation] = ->
          objects = {}
          angular.forEach cache[relation], (obj, id) ->
            if obj["#{pluralize(table_name,1)}_id"] == object.id
              objects[id] = obj
          objects
        object[relation+"_where"] = (attrs) ->
          objs = {}
          angular.forEach cache[relation], (obj, id) ->
            add_obj_to_objs = true
            angular.forEach attrs, (val, attr) ->
              if obj[attr] != val
                add_obj_to_objs = false
            if obj["#{pluralize(table_name,1)}_id"] == object.id && add_obj_to_objs
              objs[obj.id] = obj
          objs

      else if "has_many_through" of relation
        throughRelation(relation.has_many_through.through, relation.has_many_through.has_many)

      else if "has_and_belongs_to_many" of relation
        throughRelation(table_name + "_" + relation, relation)
