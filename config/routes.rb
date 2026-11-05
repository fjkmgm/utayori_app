Rails.application.routes.draw do
  root "static_pages#top"

  resources :users, only: %i[new create]

  get 'login', to: 'user_sessions#new', as: :login
  post 'login', to: 'user_sessions#create'
  delete 'logout', to: 'user_sessions#destroy', as: :logout

  get "up" => "rails/health#show", as: :rails_health_check
end