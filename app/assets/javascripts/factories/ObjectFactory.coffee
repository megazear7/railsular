angular.module('simapp').factory 'ObjectFactory', (DataCache,$http,$q) ->
  (table_name, object, relations, url_prefix = "", cache = DataCache) ->

    object.after_save = []
    object.after_failed_save = []
    object.after_successful_save = []

    object.save = ->
      $http.post("#{url_prefix}#{pluralize(table_name, 1)}/#{object.id}/update", object)
        .success (data) ->
          angular.forEach object.after_successful_save, (method) ->
            method(data)
        .error (data) ->
          obj = data[pluralize(table_name, 1)]
          angular.forEach Object.keys(obj), (attr) ->
            cache[table_name][obj.id][attr] = obj[attr]
          angular.forEach object.after_failed_save, (method) ->
            method(data)
          angular.forEach object.after_save, (method) ->
            method(data)

    object.after_delete = []
    object.after_failed_delete = []
    object.after_successful_delete = []

    object.delete = ->
      delete cache[table_name][object.id]
      $http.delete("#{url_prefix}#{pluralize(table_name, 1)}/#{object.id}/delete")
        .success (data) ->
          angular.forEach object.after_successful_delete, (method) ->
            method(data)
        .error (data) ->
          cache[table_name][object.id] = object
          angular.forEach object.after_failed_delete, (method) ->
            method(data)
          angular.forEach object.after_delete, (method) ->
            method(data)

    object.after_start_edit = []

    object.startEdit = ->
      this.editing = true
      angular.forEach object.after_start_edit (method) ->
        method()

    object.after_stop_edit = []

    object.stopEdit = ->
      object.save()
      this.editing = false
      angular.forEach object.after_stop_edit (method) ->
        method()

    angular.forEach relations, (relation) ->

      if "belongs_to" of relation
        if "polymorphic" of relation
          relation_table = pluralize(object[relation.belongs_to+"_type"].toLowerCase())
          relation = relation.belongs_to
        else
          relation_table = pluralize(relation.belongs_to)
          relation = relation.belongs_to
        object[relation] = ->
          cache[relation_table][object["#{relation}_id"]]

      else if ("has_many" of relation) and not ("through" of relation)
        if "as" of relation
          foreign_key_name = relation.as + "_id"
        else
          foreign_key_name = pluralize(table_name,1) + "_id"
        relation_table = relation.has_many
        relation = relation.has_many
        object[relation] = ->
          objects = {}
          angular.forEach cache[relation_table], (obj, id) ->
            if obj[foreign_key_name] == object.id
              objects[id] = obj
          objects
        object[relation+"_where"] = (attrs) ->
          objs = {}
          angular.forEach cache[relation_table], (obj, id) ->
            add_obj_to_objs = true
            angular.forEach attrs, (val, attr) ->
              if obj[attr] != val
                add_obj_to_objs = false
            if obj[foreign_key_name] == object.id && add_obj_to_objs
              objs[obj.id] = obj
          objs

      else if ("has_many" of relation) and ("through" of relation)
        through = relation.through
        relation = relation.has_many
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

      else if "has_and_belongs_to_many" of relation
        relation = relation.has_and_belongs_to_many
        table_names = []
        table_names.push(relation)
        table_names.push(table_name)
        through = table_names.sort().join("_")

        object[relation] = ->
          objs = {}
          angular.forEach cache[through], (val) ->
            if val[pluralize(table_name,1) + "_id"] == object.id
              obj = cache[relation][val[pluralize(relation,1) + "_id"]]
              objs[obj.id] = obj
          objs

        object["add_#{pluralize(relation,1)}"] = (other) ->
          relation_id_string = pluralize(relation,1)+"_id"
          model_id_string = pluralize(table_name,1)+"_id"
          join = {}
          join[relation_id_string] = other.id
          join[model_id_string] = object.id
          cache[through].push(join)
          $http.post(url_prefix + through, join)

        object["remove_#{pluralize(relation,1)}"] = (other) ->
          relation_id_string = pluralize(relation,1)+"_id"
          model_id_string = pluralize(table_name,1)+"_id"
          join = {}
          join[relation_id_string] = other.id
          join[model_id_string] = object.id
          angular.forEach cache[through], (join_to_remove, index) ->
            if join_to_remove[relation_id_string] == other.id && join_to_remove[model_id_string] == object.id
              cache[through].splice(index, 1)
          $http.delete(url_prefix + through, join)
