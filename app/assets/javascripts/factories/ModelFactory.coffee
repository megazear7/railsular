angular.module('simapp').factory('ModelFactory', (DataCache,$http,$q) ->
  (table_name, addMethods, options = {}) ->
    options["url_prefix"] = "" if "url_prefix" not of options
    options["cache"] = DataCache if "cache" not of options
    {
      all: ->
        options["cache"][table_name]
      where: (attrs) ->
        objs = {}
        angular.forEach options["cache"][table_name], (obj, obj_id) ->
          add_obj_to_objs = true
          angular.forEach attrs, (val, attr) ->
            if obj[attr] != val
              add_obj_to_objs = false
          if add_obj_to_objs
            objs[obj.id] = obj
        objs
      find: (id) ->
        options["cache"][table_name][id]
      find_by: (attrs) ->
        obj = false
        angular.forEach options["cache"][table_name], (tmp_obj, tmp_obj_id) ->
          isFound = true
          angular.forEach attrs, (val, attr) ->
            if tmp_obj[attr] != val
              isFound = false
          if isFound
            obj = tmp_obj
        if obj
          return obj
        else
          return false
      create: (obj) ->
        return $q( (resolve, reject) ->
          $http.post("#{options["url_prefix"]}#{pluralize(table_name, 1)}/create", obj)
            .success (data) ->
              options["cache"][table_name][data[pluralize(table_name, 1)].id] = data[pluralize(table_name, 1)]
              addMethods(data[pluralize(table_name, 1)])
              resolve(options["cache"][table_name][data[pluralize(table_name, 1)].id])
              options.after_successful_create(data) if "after_successful_create" of options
              options.after_create(data) if "after_create" of options
            .error (data) ->
              reject(data)
              options.after_failed_create(data) if "after_failed_create" of options
              options.after_create(data) if "after_create" of options
              alert("could not create #{pluralize(table_name, 1)} due to server error")
        )
    }
)
