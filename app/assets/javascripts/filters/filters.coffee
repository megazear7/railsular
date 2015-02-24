angular.module('receta')
.filter('titlize', ->
  (str) ->
    str[0].toUpperCase() + str.slice(1)
)
.filter('pluralize', ->
  (str) ->
    pluralize(str)
)
