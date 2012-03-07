Joblander::Application.routes.draw do
  get "logout" => "sessions#destroy", :as => "logout"
  get "login" => "sessions#new", :as => "login"
  get "signup" => "users#new", :as => "signup"
  root :to => "users#new"
  resources :users do
    resources :positions
  end
  resources :sessions

  # The priority is based upon order of creation:
  # first created -> highest priority.

  # Sample of regular route:
  #   match 'products/:id' => 'catalog#view'
  # Keep in mind you can assign values other than :controller and :action

  # Sample of named route:
  #   match 'products/:id/purchase' => 'catalog#purchase', :as => :purchase
  # This route can be invoked with purchase_url(:id => product.id)

  # Sample resource route (maps HTTP verbs to controller actions automatically):
  #   resources :products

  # Sample resource route with options:
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

  # Sample resource route with sub-resources:
  #   resources :products do
  #     resources :comments, :sales
  #     resource :seller
  #   end

  # Sample resource route with more complex sub-resources
  #   resources :products do
  #     resources :comments
  #     resources :sales do
  #       get 'recent', :on => :collection
  #     end
  #   end

  # Sample resource route within a namespace:
  #   namespace :admin do
  #     # Directs /admin/products/* to Admin::ProductsController
  #     # (app/controllers/admin/products_controller.rb)
  #     resources :products
  #   end

  # You can have the root of your site routed with "root"
  # just remember to delete public/index.html.
  # root :to => 'welcome#index'

  # See how all your routes lay out with "rake routes"

  # This is a legacy wild controller route that's not recommended for RESTful applications.
  # Note: This route will make all actions in every controller accessible via GET requests.
  # match ':controller(/:action(/:id(.:format)))'
end
#== Route Map
# Generated on 06 Mar 2012 20:15
#
#              login GET    /login(.:format)                             sessions#new
#             signup GET    /signup(.:format)                            users#new
#               root        /                                            users#new
#     user_positions GET    /users/:user_id/positions(.:format)          positions#index
#                    POST   /users/:user_id/positions(.:format)          positions#create
#  new_user_position GET    /users/:user_id/positions/new(.:format)      positions#new
# edit_user_position GET    /users/:user_id/positions/:id/edit(.:format) positions#edit
#      user_position GET    /users/:user_id/positions/:id(.:format)      positions#show
#                    PUT    /users/:user_id/positions/:id(.:format)      positions#update
#                    DELETE /users/:user_id/positions/:id(.:format)      positions#destroy
#              users GET    /users(.:format)                             users#index
#                    POST   /users(.:format)                             users#create
#           new_user GET    /users/new(.:format)                         users#new
#          edit_user GET    /users/:id/edit(.:format)                    users#edit
#               user GET    /users/:id(.:format)                         users#show
#                    PUT    /users/:id(.:format)                         users#update
#                    DELETE /users/:id(.:format)                         users#destroy
#           sessions GET    /sessions(.:format)                          sessions#index
#                    POST   /sessions(.:format)                          sessions#create
#        new_session GET    /sessions/new(.:format)                      sessions#new
#       edit_session GET    /sessions/:id/edit(.:format)                 sessions#edit
#            session GET    /sessions/:id(.:format)                      sessions#show
#                    PUT    /sessions/:id(.:format)                      sessions#update
#                    DELETE /sessions/:id(.:format)                      sessions#destroy
