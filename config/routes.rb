Receta::Application.routes.draw do
  get 'project/create'

  get 'project/show'

  get 'project/index'

  get 'project/update'

  get 'project/delete'

  get 'geometry/create'

  get 'geometry/show'

  get 'geometry/index'

  get 'geometry/update'

  get 'geometry/delete'

  get 'assigned_geo/create'

  get 'assigned_geo/show'

  get 'assigned_geo/index'

  get 'assigned_geo/update'

  get 'assigned_geo/delete'

  get 'simulation/create'

  get 'simulation/show'

  get 'simulation/index'

  get 'simulation/update'

  get 'simulation/delete'

  root 'home#index'

  resources :recipes, only: [:index, :show, :create, :update, :destroy]
end
