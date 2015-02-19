angular.module('receta').factory('DataCache', ->
  {
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
            description: "blah blaj"
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
            name: "SimB"
            id: 3
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
        4:
          {
            name: "AnotherSim"
            id: 4
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
        2:
          {
            name: "TestAgainSim"
            id: 2
            project_id: 2
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
            project_id: 2
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
        8:
          {
            name: "Simulation Test"
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
        11:
          {
            name: "Sim Test"
            id: 11
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
            simulation_id: 1
            description: "blah"
            editing: false
            type: "inlet"
            attributes:
              {
                vx: 1.24
                vy: 2.45
                vz: 1.9
              }
          }
        2:
          {
            name: "Geometry Again"
            id: 2
            project_id: 1
            simulation_id: 1
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
            project_id: 2
            simulation_id: 11
            description: "blah"
            editing: false
            type: "outlet"
            attributes:
              {
              }
          }
        4:
          {
            name: "Geo Again"
            id: 4
            project_id: 2
            simulation_id: 11
            description: "blah"
            editing: false
            type: "inlet"
            attributes:
              {
                vx: 1.24
                vy: 2.45
                vz: 1.9
              }
          }
      }
  }
)
