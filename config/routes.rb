CareplusIntranet::Application.routes.draw do
  resources :blog_authors, path: 'blog-authors', only: [:index]
  resources :blog_articles, path: 'blog-articles', only: [:index, :show]

  resources :members
  resources :venues, only: [:index]
  resources :award_suggested_nominations
  resources :report_facilities, only: [:new, :create]
  resources :staff_suggestions, only: [:new, :create]
  resources :red_tape_challenges, only: [:new, :create]
  resources :rumours, only: [:index, :show]
  resources :award_votes
  resources :award_nominations
  resources :sliders
  resources :staff_benefits
  resources :sale_categories
  resources :events
  resources :shoutboxes
  resources :articles
  resources :stored_documents, only: [:index, :new, :create]
  resources :stored_images, only: [:index, :new, :create]
  resources :pages
  resources :user_sessions, only: [:create, :destroy, :new]
  resources :user_password_resets, only: [:create, :edit, :new, :update]
  resources :emails, only: [:show]

  resources :awards do
    collection do
      get 'nominate'
      get 'vote'
      get 'winners'
    end
  end

  resources :users do
    get :posts, on: :collection
    get :sales, on: :collection
    get :rumours, on: :collection
  end

  namespace :admin do
    manticore_resources :stored_documents
    manticore_resources :stored_images
    manticore_resources :staff_benefits
    manticore_resources :sale_categories
    manticore_resources :users
    manticore_resources :shoutboxes
    manticore_resources :events
    manticore_resources :articles
    manticore_resources :members
    manticore_resources :venues
    manticore_resources :footer_links
    manticore_resources :sliders
    manticore_resources :awards do
      manticore_resources :award_nominations
      manticore_resources :award_suggested_nominations
      manticore_resources :award_votes
    end
    # manticore_resources :award_suggested_nominations
    # manticore_resources :award_votes
    # manticore_resources :award_nominations
    chronicler_resources :emails do
      post 'change_template', on: :member
      post 'new_item', on: :member
      post 'destroy_item', on: :member
      post 'create_campaign', on: :member
      post 'update_campaign', on: :member
      post 'send_test', on: :member
      post 'send_now', on: :member
    end
    chronicler_resources :pages
    chronicler_resources :events
    chronicler_resources :articles
    chronicler_resources :sliders
    chronicler_resources :awards
    chronicler_resources :staff_benefits
    chronicler_resources :venues
    chronicler_resources :members
    chronicler_resources :blog_articles
    chronicler_resources :blog_authors
    chronicler_resources :blog_articles
  end

  # match "signup" => "users#new", :as => "signup"
  match 'login' => 'user_sessions#new', :as => 'login'
  match 'logout' => 'user_sessions#destroy', :as => 'logout'

  root to: 'application#index'

  mount Manticore::Engine => '/admin'
end
