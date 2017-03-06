Rails.application.routes.draw do

  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks', :registrations => "users/registrations" }

  root to: 'pages#home'

  get "/my_bookings", to: 'profiles#my_bookings'
  get "/my_requests", to: 'profiles#my_requests'
  get "/created_events", to: 'profiles#created_events'

  get '/my_profile', to: 'profiles#my_profile'
  get "my_profile/edit", to: "profiles#edit"
  patch "my_profile/", to: "profiles#update"
  get "/profile/:id", to: "profiles#show", as: "profile"

  resources :notifications, only: [:index, :destroy]

  get "/bookings/pending_denied_show/:id", to: "bookings#pending_denied_show", as: "pending"

  mount Attachinary::Engine => "/attachinary"

  resources :events do
    member do
      get :protected
    end

    resources :bookings, only: [:new, :create]
  end

  resources :chat_rooms, only: [:new, :create, :show, :index]
  mount ActionCable.server => '/cable'

  resources :conversations do
    resources :messages
  end

  resources :bookings, except: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
