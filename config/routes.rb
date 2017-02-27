Rails.application.routes.draw do
  get 'profiles/show'

  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'

  get "/my_profile", to: 'profiles#my_profile', as: "profile"
  get "/profile/edit", to: 'profiles#edit'

  mount Attachinary::Engine => "/attachinary"

  resources :events do
    resources :bookings, only: [:new, :create]
  end

  resources :bookings, except: [:new, :create]
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
