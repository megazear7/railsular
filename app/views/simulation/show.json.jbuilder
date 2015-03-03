json.set! :simulation do
  json.extract! @simulation, :id, :project_id, :name, :description, :measurement_scale, :fluid_type, :kinematic_viscosity, :density, :steps, :created_at, :updated_at
end
json.set! :message, @message
