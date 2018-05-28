Rails.application.routes.draw do
  
  post 'admin/order/close'
  post 'admin/order/destroy'
  get 'admin/order/show'
  get 'admin/order/show/:id' => 'admin/order#show'
  get 'admin/order/index'

  get 'checkout/index'
  post 'checkout/submit_order'
  get 'checkout/thank_you'

  get 'cart/add'
  get 'cart/remove'
  get 'cart/clear'

  root :to => 'about#index'

  get 'about' => 'about#index'
  get 'admin/producer' => 'admin/producer#index'
  get 'admin/artist' => 'admin/artist#index'
  get 'admin/disc' => 'admin/disc#index'
  get 'admin/order' => 'admin/order#index'
  get 'catalog' => 'catalog#index'
  get 'checkout' => 'checkout#index'

  get 'about/index' # generada por defecto al crear la plantilla desde rails

  get 'admin/producer/new'
  post 'admin/producer/create'
  get 'admin/producer/edit'
  post 'admin/producer/update'
  post 'admin/producer/destroy'
  get 'admin/producer/show'
  get 'admin/producer/show:id' => 'admin/producer#show'
  get 'admin/producer/index'


  get 'admin/artist/new'
  post 'admin/artist/create'
  get 'admin/artist/edit'
  post 'admin/artist/update'
  post 'admin/artist/destroy'
  get 'admin/artist/show'
  get 'admin/artist/show/:id' => 'admin/artist#show'
  get 'admin/artist/index'

  get 'admin/disc/new'
  post 'admin/disc/create'
  get 'admin/disc/edit'
  post 'admin/disc/update'
  post 'admin/disc/destroy'
  get 'admin/disc/show'
  get 'admin/disc/show/:id' => 'admin/artist#show'
  get 'admin/disc/index'


  get 'catalog/show'
  get 'catalog/show/:id' => 'catalog#show'
  get 'catalog/index'
  get 'catalog/latest'
  get 'catalog/rss'
  get 'catalog/search'

  get 'cart/add'
  post 'cart/add'
  get 'cart/remove'
  post 'cart/remove'
  get 'cart/clear'
  post 'cart/clear'

  get 'user_session/new'
  get 'user_session/create' # for showing failed login screen after restarting web server
  post 'user_session/create'
  get 'user_session/destroy'

  get 'user/new'
  post 'user/create'
  get 'user/show'
  get 'user/show/:id' => 'user#show'
  get 'user/edit'
  post 'user/update'

  get 'password_reset/new'
  post 'password_reset/create'
  get 'password_reset/edit'
  post 'password_reset/update'

end

  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

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