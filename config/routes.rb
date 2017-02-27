Rails.application.routes.draw do
  get 'profiles/show'

  devise_for :users,
  controllers: { omniauth_callbacks: 'users/omniauth_callbacks' }
  root to: 'pages#home'
  resources :events

  get "/my_profile", to: 'profiles#my_profile', as: "profile"
  get "/profile/edit", to: 'profiles#edit'

  mount Attachinary::Engine => "/attachinary"
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
