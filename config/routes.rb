require "sidekiq/web"

Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Render dynamic PWA files from app/views/pwa/* (remember to link manifest in application.html.erb)
  # get "manifest" => "rails/pwa#manifest", as: :pwa_manifest
  # get "service-worker" => "rails/pwa#service_worker", as: :pwa_service_worker

  # Locale scope for internationalization
  scope "(:locale)", locale: /#{I18n.available_locales.join('|')}/ do
    # Defines the root path route ("/")
    root "dashboard#index"

    # Devise routes for user authentication
    devise_for :users

    # Teach routes
    namespace :teach do
      get "dashboard", to: "dashboard#index"
      resources :courses, only: %i[new create]
    end
  end

  authenticate :user, ->(user) { user.admin? } do
    # Sidekiq web interface
    mount Sidekiq::Web, at: "sidekiq"

    # PgHero for database insights
    mount PgHero::Engine, at: "pghero"

    # Avo for admin interface
    mount_avo at: "/avo"
  end

  # Lookbook for UI development
  mount Lookbook::Engine, at: "/lookbook" if Rails.env.development?
end
