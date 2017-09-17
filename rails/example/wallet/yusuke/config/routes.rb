# == Route Map
#
#          Prefix Verb URI Pattern                Controller#Action
#       home_home GET  /home/home(.:format)       home#home
#  indexers_index GET  /indexers/index(.:format)  indexers#index
#   indexers_show GET  /indexers/:id(.:format)    indexers#show
# indexers_create GET  /indexers/create(.:format) indexers#create
#            root GET  /                          home#home
#

Rails.application.routes.draw do
  get 'home/home'

  get 'indexers', to: 'indexers#index', as: 'indexers_index'
  get 'indexers/new', to: 'indexers#new', as: 'indexers_new'
  get 'indexers/:id', to: 'indexers#show', as: 'indexers_show'

  post 'indexers', to: 'indexers#create', as: 'indexers_create'


  # The priority is based upon order of creation: first created -> highest priority.
  # See how all your routes lay out with "rake routes".

  # You can have the root of your site routed with "root"
   root 'home#home'

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
