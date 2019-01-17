require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :admin do
    resources :submissions
    resources :users
    resources :reports

    root to: "submissions#index"
  end

  namespace :api do
    post 'authenticate', to: 'authentication#authenticate'

    post 'users/register', to: 'users#register'
    get 'users/me', to: 'users#show'

    post 'password/forgot', to: 'password#forgot'
    post 'password/validate_token', to: 'password#validate_token'
    post 'password/reset', to: 'password#reset'
    put 'password/update', to: 'password#update'

    resources :submissions, only: [:index, :create]
    get 'submissions/mine', to: 'submissions#mine'
    get 'submissions/favorites', to: 'submissions#favorites'
    post 'submissions/:id/favorite', to: 'submissions#favorite'
    delete 'submissions/:id/unfavorite', to: 'submissions#unfavorite'

    resources :reports, only: [:create]
    get 'reports/codes', to: 'reports#codes'
  end

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    # Protect against timing attacks:
    # - See https://codahale.com/a-lesson-in-timing-attacks/
    # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['ADMIN_USER'])) & ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['ADMIN_PASSWORD']))
  end if Rails.env.production?
  mount Sidekiq::Web => '/jobs'

end
