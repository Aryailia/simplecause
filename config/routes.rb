Rails.application.routes.draw do  
  root 'organisations#index'

  # For sessions
  resources :passwords, controller: "clearance/passwords", only: [:create, :new]
  resource :session, controller: "clearance/sessions", only: [:create]

  resources :users, controller: "clearance/users", only: [:create] do
    resource :password,
      controller: "clearance/passwords",
      only: [:create, :edit, :update]
  end

  get "/sign_in" => "clearance/sessions#new", as: "sign_in"
  delete "/sign_out" => "clearance/sessions#destroy", as: "sign_out"
  get "/sign_up" => "clearance/users#new", as: "sign_up"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
 #the routes for follow
  
  get "/auth/:provider/callback" => "sessions#create_from_omniauth"

  #the routes for organisations 
  resources :organisations do 
    resources :contributors

    # For creating events and listing them only, creation is dependent on organisation
    resources :events, only: [:index, :create, :new]

    # For Follows
    post 'follow' => 'follows#create'
    delete 'unfollow' => 'follows#destroy'
  end

  # Other stuff related to events
  resources :events, only: [:index, :show, :edit, :update, :destroy]
  resources :attendees, only: [:create, :destroy]
  
  # User actions with organisations
  # resources :follows
end
