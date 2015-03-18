angular.module('simapp').factory('ModelFactory', (DataCache,$http,$q) ->
  (table_name, addMethods, cache = DataCache, url_prefix = "") ->
    {
      all: ->
        cache[table_name]
      find: (id) ->
        cache[table_name][id]
      find_by: (attrs) ->
        obj = false
        angular.forEach cache[table_name], (tmp_obj, tmp_obj_id) ->
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
        # todo use reject inside of error so that the client of this create method can do something in the reject case
        return $q( (resolve, reject) ->
          $http.post("#{url_prefix}#{pluralize(table_name, 1)}/create", obj)
            .success (data, status, headers, config) ->
              cache[table_name][data[pluralize(table_name, 1)].id] = data[pluralize(table_name, 1)]
              addMethods(data[pluralize(table_name, 1)])
              resolve(cache[table_name][data[pluralize(table_name, 1)].id])
            .error (data, status, headers, config) ->
              alert("could not create #{pluralize(table_name, 1)} due to server error")
        )
    }
)
