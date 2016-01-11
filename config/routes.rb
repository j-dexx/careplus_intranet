CareplusIntranet::Application.routes.draw do

  
  namespace :admin do manticore_resources :members end

  resources :members


  namespace :admin do manticore_resources :venues end

  resources :venues, :only => [:index]


  namespace :admin do manticore_resources :footer_links end

  # namespace :admin do manticore_resources :award_suggested_nominations end

  resources :award_suggested_nominations

  resources :report_facilities, :only => [:new, :create]
  resources :staff_suggestions, :only => [:new, :create]
  resources :red_tape_challenges, :only => [:new, :create]
  
  resources :rumours, :only => [:index, :show]

  # namespace :admin do manticore_resources :award_votes end

  resources :award_votes


  #namespace :admin do manticore_resources :award_nominations end

  resources :award_nominations


  namespace :admin do
    manticore_resources :awards do
      manticore_resources :award_nominations
      manticore_resources :award_suggested_nominations
      manticore_resources :award_votes
    end
  end

  resources :awards do
    collection do
      get "nominate"
      get "vote"
      get "winners"
    end
  end


  namespace :admin do manticore_resources :sliders end

  resources :sliders


  namespace :admin do manticore_resources :staff_benefits end

  resources :staff_benefits


  namespace :admin do manticore_resources :sale_categories end

  resources :sale_categories


  namespace :admin do manticore_resources :users end

  namespace :admin do manticore_resources :shoutboxes end

  resources :users do
    get :posts, :on => :collection
    get :sales, :on => :collection
    get :rumours, :on => :collection
  end


  namespace :admin do manticore_resources :events end

  resources :events


  resources :shoutboxes


  namespace :admin do manticore_resources :articles end

  resources :articles

  resources :stored_documents, :only => [:index, :new, :create]
  resources :stored_images, :only => [:index, :new, :create]
  manticore_resources :stored_documents
  manticore_resources :stored_images


  namespace :admin do
    chronicler_resources :emails do
      post 'change_template', :on => :member
      post 'new_item', :on => :member
      post 'destroy_item', :on => :member
      post 'create_campaign', :on => :member
      post 'update_campaign', :on => :member
      post 'send_test', :on => :member
      post 'send_now', :on => :member
    end
    chronicler_resources :pages
    chronicler_resources :events
    chronicler_resources :articles
    chronicler_resources :sliders
    chronicler_resources :awards
    chronicler_resources :staff_benefits
    chronicler_resources :venues
    chronicler_resources :members
  end

  resources :pages
  
  resources :user_sessions, :only => [:create, :destroy, :new]
  resources :user_password_resets, :only => [:create, :edit, :new, :update]
  resources :emails, :only => [:show]
  
  #match "signup" => "users#new", :as => "signup"
  match "login" => "user_sessions#new", :as => "login"
  match "logout" => "user_sessions#destroy", :as => "logout"

  root :to => "application#index"

  mount Manticore::Engine => "/admin"

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
  # match ':controller(/:action(/:id))(.:format)'
end
