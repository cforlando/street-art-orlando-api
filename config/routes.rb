require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :admin do
    resources :submissions
    resources :users

    root to: "submissions#index"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  mount Sidekiq::Web => '/workers'

  namespace :api do
    resources :submissions, only: [:index, :create]

    post 'authenticate', to: 'authentication#authenticate'
    post 'register', to: 'users#register'
  end

end
