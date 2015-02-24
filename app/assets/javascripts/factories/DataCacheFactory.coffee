angular.module('receta').factory('DataCache', ->
  {
    geometries_simulations:
      {
        "1_1":
          {
            geometry_id: 1
            simulation_id: 1
            attributes: { vx: 1.16, vy: 3.32, vz: 1.2 }
          }
        "2_1":
          {
            geometry_id: 2
            simulation_id: 1
            attributes: {}
          }
        "3_1":
          {
            geometry_id: 3
            simulation_id: 1
            attributes: {}
          }
        "4_1":
          {
            geometry_id: 4
            simulation_id: 1
            attributes: { vx: 3.67, vy: 1.65, vz: 2.3 }
          }
        "5_1":
          {
            geometry_id: 5
            simulation_id: 1
            attributes: { vx: 3.01, vy: 6.4, vz: 3.1 }
          }
        "1_2":
          {
            geometry_id: 1
            simulation_id: 2
            attributes: { vx: 8.3, vy: 1.65, vz: 2.3 }
          }
        "2_3":
          {
            geometry_id: 2
            simulation_id: 3
            attributes: {}
          }
        "3_3":
          {
            geometry_id: 3
            simulation_id: 3
            attributes: {}
          }
        "4_5":
          {
            geometry_id: 4
            simulation_id: 5
            attributes: { vx: 3.7, vy: 1.45, vz: 4.5 }
          }
        "5_5":
          {
            geometry_id: 5
            simulation_id: 5
            attributes: { vx: 3.6, vy: 1.01, vz: 72 }
          }
      }
    geometry_types:
      {
        inlet:
          {
            name: "inlet"
            attributes: ["vx", "vy", "vz"]
          }
        outlet:
          {
            name: "outlet"
            attributes: []
          }
        wall:
          {
            name: "wall"
            attributes: []
          }
      }
    projects:
      {
        1:
          {
            name: "Test Project"
            id: 1
            description: "test project description"
            editing: false

          }
        2:
          {
            name: "Project Two"
            id: 2
            description: "test project description"
            editing: false
          }
      }
    simulations:
      {
        1:
          {
            name: "Test Sim"
            id: 1
            project_id: 1
            description: "This is a description for the test sim simulation. These description look kind of bad when they are short. Should we think about the display of these descriptions?"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        2:
          {
            name: "SimB"
            id: 2
            project_id: 1
            description: "blah blah"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        3:
          {
            name: "AnotherSim"
            id: 3
            project_id: 1
            description: "blah"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        4:
          {
            name: "TestAgainSim"
            id: 4
            project_id: 1
            description: "blah blaj"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        5:
          {
            name: "SimCCC"
            id: 5
            project_id: 1
            description: "blah blah"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        6:
          {
            name: "YetAnotherSim"
            id: 6
            project_id: 2
            description: "blah"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        7:
          {
            name: "Simulation Test"
            id: 7
            project_id: 2
            description: "blah"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
        8:
          {
            name: "Sim Test"
            id: 8
            project_id: 2
            description: "blah"
            status: "Queued"
            editing: false
            measurement_scale: "mm"
            fluid_type: "water"
            kinematic_viscosity: 3.2
            density: 2.3
            steps: 120
          }
      }
    geometries:
      {
        1:
          {
            name: "GEO B"
            id: 1
            project_id: 1
            description: "blah"
            editing: false
            type: "inlet"
            attributes:
              {
              }
          }
        2:
          {
            name: "Geometry Again"
            id: 2
            project_id: 1
            description: "blah"
            editing: false
            type: "outlet"
            attributes:
              {
              }
          }
        3:
          {
            name: "GEO C"
            id: 3
            project_id: 1
            description: "blah"
            editing: false
            type: "outlet"
            attributes:
              {
              }
          }
        4:
          {
            name: "Another Geo"
            id: 4
            project_id: 1
            description: "blah"
            editing: false
            type: "inlet"
            attributes:
              {
              }
          }
        5:
          {
            name: "Geo Again"
            id: 5
            project_id: 1
            description: "blah"
            editing: false
            type: "inlet"
            attributes:
              {
              }
          }
      }
  }
)
