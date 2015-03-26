SimApp::Application.routes.draw do

  scope 'simapp' do
    scope 'admin' do

      get 'attribute_descriptor_values' => 'attribute_descriptor_value#index', defaults: { format: 'json' }
      get 'attribute_descriptor_value/:id' => 'attribute_descriptor_value#show', defaults: { format: 'json' }
      post 'attribute_descriptor_value/create' => 'attribute_descriptor_value#create', defaults: { format: 'json' }
      post 'attribute_descriptor_value/:id/update' => 'attribute_descriptor_value#update', defaults: { format: 'json' }
      delete 'attribute_descriptor_value/:id/delete' => 'attribute_descriptor_value#delete', defaults: { format: 'json' }

      get 'attribute_descriptors' => 'attribute_descriptor#index', defaults: { format: 'json' }
      get 'attribute_descriptor/:id' => 'attribute_descriptor#show', defaults: { format: 'json' }
      post 'attribute_descriptor/create' => 'attribute_descriptor#create', defaults: { format: 'json' }
      post 'attribute_descriptor/:id/update' => 'attribute_descriptor#update', defaults: { format: 'json' }
      delete 'attribute_descriptor/:id/delete' => 'attribute_descriptor#delete', defaults: { format: 'json' }

      get 'job_descriptors' => 'job_descriptor#index', defaults: { format: 'json' }
      get 'job_descriptor/:id' => 'job_descriptor#show', defaults: { format: 'json' }
      post 'job_descriptor/create' => 'job_descriptor#create', defaults: { format: 'json' }
      post 'job_descriptor/:id/update' => 'job_descriptor#update', defaults: { format: 'json' }
      delete 'job_descriptor/:id/delete' => 'job_descriptor#delete', defaults: { format: 'json' }

      get 'geometry_types' => 'geometry_type#index', defaults: { format: 'json' }
      get 'geometry_type/:id' => 'geometry_type#show', defaults: { format: 'json' }
      post 'geometry_type/create' => 'geometry_type#create', defaults: { format: 'json' }
      post 'geometry_type/:id/update' => 'geometry_type#update', defaults: { format: 'json' }
      delete 'geometry_type/:id/delete' => 'geometry_type#delete', defaults: { format: 'json' }

      get 'apps' => 'app#index', defaults: { format: 'json' }
      get 'app/:id' => 'app#show', defaults: { format: 'json' }
      post 'app/create' => 'app#create', defaults: { format: 'json' }
      post 'app/:id/update' => 'app#update', defaults: { format: 'json' }
      delete 'app/:id/delete' => 'app#delete', defaults: { format: 'json' }
    end

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
    get 'geometry_types_overview' => 'geometry#types', defaults: { format: 'json' }
    post 'geometry/:id/update_file' => 'geometry#update_file', defaults: { format: 'json' }
    post 'geometry/:id/run' => 'geometry#run', defaults: { format: 'json' }

    get 'assigned_geometries' => 'assigned_geo#index', defaults: { format: 'json' }
    get 'assigned_geometry/:id' => 'assigned_geo#show', defaults: { format: 'json' }
    post 'assigned_geometry/create' => 'assigned_geo#create', defaults: { format: 'json' }
    post 'assigned_geometry/:id/update' => 'assigned_geo#update', defaults: { format: 'json' }
    delete 'assigned_geometry/:id/delete' => 'assigned_geo#delete', defaults: { format: 'json' }

    get 'simulations' => 'simulation#index', defaults: { format: 'json' }
    get 'simulations/attributes' => 'simulation#attributes', defaults: { format: 'json' }
    get 'simulation/:id' => 'simulation#show', defaults: { format: 'json' }
    post 'simulation/create' => 'simulation#create', defaults: { format: 'json' }
    post 'simulation/:id/update' => 'simulation#update', defaults: { format: 'json' }
    delete 'simulation/:id/delete' => 'simulation#delete', defaults: { format: 'json' }
    post 'simulation/:id/run' => 'simulation#run', defaults: { format: 'json' }
    
    get 'results' => 'result#index', defaults: { format: 'json' }
    get 'result/:id' => 'result#show', defaults: { format: 'json' }
    post 'result/create' => 'result#create', defaults: { format: 'json' }
    post 'result/:id/update' => 'result#update', defaults: { format: 'json' }
    delete 'result/:id/delete' => 'result#delete', defaults: { format: 'json' }

    root 'home#index'
  end

end
