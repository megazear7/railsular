Receta::Application.routes.draw do

  get 'projects' => 'project#index'
  get 'project/:id' => 'project#show'
  post 'project/create' => 'project#create'
  post 'project/:id/update' => 'project#update'
  delete 'project/:id/delete' => 'project#delete'

  get 'geometries' => 'geometry#index'
  get 'geometry/:id' => 'geometry#show'
  post 'geometry/create' => 'geometry#create'
  post 'geometry/:id/update' => 'geometry#update'
  delete 'geometry/:id/delete' => 'geometry#delete'

  get 'assigned_geos' => 'assigned_geo#index'
  get 'assigned_geo/:id' => 'assigned_geo#show'
  post 'assigned_geo/create' => 'assigned_geo#create'
  post 'assigned_geo/:id/update' => 'assigned_geo#update'
  delete 'assigned_geo/:id/delete' => 'assigned_geo#delete'

  get 'simulations' => 'simulation#index'
  get 'simulation/:id' => 'simulation#show'
  post 'simulation/create' => 'simulation#create'
  post 'simulation/:id/update' => 'simulation#update'
  delete 'simulation/:id/delete' => 'simulation#delete'

end
