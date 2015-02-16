controllers = angular.module('controllers')
controllers.controller("TreeController", [ '$scope', '$routeParams', '$location', '$resource',
  ($scope,$routeParams,$location,$resource)->
    $scope.template = { url: "modules/tree.html" }
    $scope.title = "Tree Controller"
    $scope.message = "I am a module-level Angular controller. I am allowed to do client side page navigation, but I cannot expect to be dependent upon any url state information (such as route information or id's and such). That is only available to layout controllers, and I am only a module controller. However, I can be used on any page that wants to plug me in."
])


$(document).ready ->
  $('#frmt').jstree({
    core: {
      check_callback: true,
      data: [
        {
          text: "Project",
          type: "root"
          state: { opened: true },
          children: [
            {
              text: "stuff",
              type: "container",
              children: [
                {
                  text: "geo1",
                  type: "geometry"
                },
                {
                  text: "sim1",
                  type: "simulation"
                }
              ]
            }
            {
              text: "more stuff",
              type: "container",
              children: [
                {
                  text: "geo2",
                  type: "geometry"
                },
                {
                  text: "sim2",
                  type: "simulation"
                }
              ]
            }
          ]
        }
      ]
    },
    "plugins" : [
      "types", "contextmenu", "dnd", "search", "unique", "wholerow"
    ],
    "types" : {
      "#" : {
        max_children: 1,
        max_depth: 10,
        valid_children: ["root"]
      },
      "root" : {
        icon: "/assets/project.png",
        valid_children: ["container", "geometry", "simulation"]
      },
      "container" : {
        icon: "/assets/folder.png",
        valid_children: ["container", "geometry", "simulation"]
      },
      "geometry" : {
        icon: "/assets/geometry.png",
        valid_children: []
      },
      "simulation" : {
        icon: "/assets/simulation.png",
        valid_children: []
      }
    },
    "contextmenu" : {
      "items": ($node) ->
        tree = $('#frmt').jstree(true)
        ret = {
          edit_item : {
            label: "Edit",
            action: (obj) -> tree.edit($node)
          },
          delete_item : {
            label: "Delete",
            action: (obj) -> tree.delete_node($node)
          }
        }
        if $node.type == "root" || $node.type == "container"
          ret.add_geometry = {
            label: "Create New Geometry",
            action: (obj) -> $node = tree.create_node($node, {"text" : "new node", "type" : "geometry" }); tree.edit($node)
            "_class" : "class"
          }
          ret.add_simulation = {
            label: "Create New Simulation",
            action: (obj) -> $node = tree.create_node($node, {"text" : "new node", "type" : "simulation" }); tree.edit($node)
            "_class" : "class"
          }
          ret.add_container = {
            label: "Create New Container",
            action: (obj) -> $node = tree.create_node($node, {"text" : "new node", "type" : "container" }); tree.edit($node)
            "_class" : "class"
          }
        return ret
    }
  })

  
  $('#frmt_search')
    .keyup ->
      if(to)
        clearTimeout(to)
      to = setTimeout ->
        v = $('#frmt_search').val()
        $('#frmt').jstree(true).search(v)
      , 250
###


###
###
  $('#frmt').jstree({
    'core' : {
      "check_callback" : true,
      'data' : [
        {
          "text" : "Project Name",
          "type" : "root",
          "id" : "1",
          "state" : {
            "opened" : true
          },
        }
      ],
      'themes': {
        'name': 'proton',
        'responsive': true
      }
    },
  })
###
