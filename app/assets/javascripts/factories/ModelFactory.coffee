angular.module('receta').factory('ModelFactory', (DataCache) ->
  (table_name, addMethods) ->
    {
      all: ->
        DataCache[table_name]
      find: (id) ->
        DataCache[table_name][id]
      find_by: (attrs) ->
        obj = false
        angular.forEach(DataCache[table_name], (tmp_obj, tmp_obj_id) ->
          isFound = true
          angular.forEach(attrs, (val, attr) ->
            if tmp_obj[attr] != val
              isFound = false
          )
          if isFound
            obj = tmp_obj
        )
        if obj
          return obj
        else
          return false
      create: (obj) ->
        # todo use $http to save this to the rails API, in the error callback we might need to revert this change
        obj.id = Math.floor((Math.random()*100000)+1)
        DataCache[table_name][obj.id] = obj
        addMethods(obj)
        DataCache[table_name][obj.id]
    }
)
