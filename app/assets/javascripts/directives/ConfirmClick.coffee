angular.module('simapp').directive('saConfirmClick', ->
  {
    priority: -1
    restrict: 'A'
    link: (scope, element, attrs) ->
      element.bind 'click', (e) ->
        message = attrs.saConfirmClick
        if (message && !confirm(message))
          e.stopImmediatePropagation()
          e.preventDefault()
  }
)
