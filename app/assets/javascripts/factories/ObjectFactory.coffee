angular.module('receta').factory('ObjectFactory', (DataCache,$http,$q) ->
  (table_name, object) ->
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
)
