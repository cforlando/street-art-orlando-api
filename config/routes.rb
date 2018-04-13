require 'sidekiq/web'

Rails.application.routes.draw do
  namespace :admin do
    resources :submissions
    resources :users

    root to: "submissions#index"
  end

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  Sidekiq::Web.use Rack::Auth::Basic do |username, password|
    # Protect against timing attacks:
    # - See https://codahale.com/a-lesson-in-timing-attacks/
    # - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
    # - Use & (do not use &&) so that it doesn't short circuit.
    # - Use digests to stop length information leaking (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
    ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(username), ::Digest::SHA256.hexdigest(ENV['ADMIN_USER'])) & ActiveSupport::SecurityUtils.secure_compare(::Digest::SHA256.hexdigest(password), ::Digest::SHA256.hexdigest(ENV['ADMIN_PASSWORD']))
  end if Rails.env.production?
  mount Sidekiq::Web => '/workers'

  namespace :api do
    resources :submissions, only: [:index, :create]

    post 'authenticate', to: 'authentication#authenticate'
    post 'register', to: 'users#register'
  end

end
