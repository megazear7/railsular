angular.module('simapp')
.filter('titlize', ->
  (str) ->
    str.replace(/\w\S*/g, (txt) ->
      txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
    )
)
.filter('pluralize', ->
  (str) ->
    pluralize(str)
)
.filter('humanize', ->
  (str) ->
    str = str.replace("_", " ")
    # capitalize each word:
    str.replace(/\w\S*/g, (txt) ->
      txt.charAt(0).toUpperCase() + txt.substr(1).toLowerCase()
    )
)
