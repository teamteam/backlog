Backlog::Application.routes.draw do
  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  get 'backlog', to: 'backlog_items#index', as: :backlog
  get 'backlog/new', to: 'backlog_items#new', as: :new_backlog_item
  post 'backlog/create', to: 'backlog_items#create', as: :create_backlog_item
  get 'backlog/:backlog_item_id', to: 'backlog_items#edit', as: :backlog_item
  patch 'backlog/:backlog_item_id', to: 'backlog_items#update', as: :update_backlog_item
  delete 'backlog/:backlog_item_id', to: 'backlog_items#destroy', as: :delete_backlog_item
  patch 'backlog/:backlog_item_id/complete', to: 'backlog_items#complete', as: :complete_backlog_item

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
