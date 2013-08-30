Backlog::Application.routes.draw do
  devise_for :users, :path => "accounts"

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  scope 'teamteam' do
    get '', to: 'backlog_items#index', as: :backlog
    get 'new', to: 'backlog_items#new', as: :new_backlog_item
    post 'create', to: 'backlog_items#create', as: :create_backlog_item
    get 'archive', to: 'backlog_items#archive', as: :archive_backlog
    scope ':backlog_item_id' do
      get '', to: 'backlog_items#edit', as: :backlog_item
      patch '', to: 'backlog_items#update', as: :update_backlog_item
      delete '', to: 'backlog_items#destroy', as: :delete_backlog_item
      get 'toggle-complete', to: 'backlog_items#toggle_complete', as: :toggle_complete_backlog_item

      get 'tasks/new', to: 'tasks#new', as: :new_task
      post 'tasks/create', to: 'tasks#create', as: :create_task
      get 'tasks/:task_id/toggle-complete', to: 'tasks#toggle_complete', as: :toggle_complete_task
      delete 'tasks/:task_id', to: 'tasks#destroy', as: :delete_task
    end
  end

  root 'application#index'

  # You can have the root of your site routed with "root"
  # root 'welcome#index'

  # Example of regular route:
  #   get 'products/:id' => 'catalog#view'

  # Example of named route that can be invoked with purchase_url(id: product.id)
  #   get 'products/:id/purchase' => 'catalog#purchase', as: :purchase

  # Example resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Example resource route with options:
  #   resources :products do
  #     member do
  #       get 'short'
  #       post 'toggle'
  #     end
  #
  #     collection do
  #       get 'sold'
  #     end
  #   end

  # Example resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Example resource route with more complex sub-resources:
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', on: :collection
  #     end
  #   end
  
  # Example resource route with concerns:
  #   concern :toggleable do
  #     post 'toggle'
  #   end
  #   resources :posts, concerns: :toggleable
  #   resources :photos, concerns: :toggleable

  # Example resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end
end
