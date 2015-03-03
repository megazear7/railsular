Receta::Application.routes.draw do

  get 'projects' => 'project#index', defaults: { format: 'json' }
  get 'project/:id' => 'project#show', defaults: { format: 'json' }
  post 'project/create' => 'project#create', defaults: { format: 'json' }
  post 'project/:id/update' => 'project#update', defaults: { format: 'json' }
  delete 'project/:id/delete' => 'project#delete', defaults: { format: 'json' }

  get 'geometries' => 'geometry#index', defaults: { format: 'json' }
  get 'geometry/:id' => 'geometry#show', defaults: { format: 'json' }
  post 'geometry/create' => 'geometry#create', defaults: { format: 'json' }
  post 'geometry/:id/update' => 'geometry#update', defaults: { format: 'json' }
  delete 'geometry/:id/delete' => 'geometry#delete', defaults: { format: 'json' }

  get 'assigned_geos' => 'assigned_geo#index', defaults: { format: 'json' }
  get 'assigned_geo/:id' => 'assigned_geo#show', defaults: { format: 'json' }
  post 'assigned_geo/create' => 'assigned_geo#create', defaults: { format: 'json' }
  post 'assigned_geo/:id/update' => 'assigned_geo#update', defaults: { format: 'json' }
  delete 'assigned_geo/:id/delete' => 'assigned_geo#delete', defaults: { format: 'json' }

  get 'simulations' => 'simulation#index', defaults: { format: 'json' }
  get 'simulation/:id' => 'simulation#show', defaults: { format: 'json' }
  post 'simulation/create' => 'simulation#create', defaults: { format: 'json' }
  post 'simulation/:id/update' => 'simulation#update', defaults: { format: 'json' }
  delete 'simulation/:id/delete' => 'simulation#delete', defaults: { format: 'json' }
  post 'simulation/:id/run' => 'simulation#run', defaults: { format: 'json' }

  root 'home#index'

end
