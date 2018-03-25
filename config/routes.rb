Rails.application.routes.draw do
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  namespace :api do
    resources :submissions

    post 'authenticate', to: 'authentication#authenticate'
    post 'register', to: 'users#register'
  end

end
