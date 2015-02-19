angular.module('receta').factory('DataCache', ->
  {
    projects:
      {
        1:
          {
            dirty: false
            name: "Test Project"
            id: 1
            description: "test project description"
            editing: false

          }
        2:
          {
            dirty: false
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
            dirty: false
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
            dirty: false
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
            dirty: false
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
            dirty: false
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
            dirty: false
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
            dirty: false
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
            dirty: false
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
            dirty: false
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
            dirty: false
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
            dirty: false
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
            dirty: false
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
            dirty: false
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


