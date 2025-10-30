Sidekiq.configure_server do |config|
  # Catch N+1 queries in Sidekiq using Prosopite
  unless Rails.env.production?
    config.server_middleware do |chain|
      require "prosopite/middleware/sidekiq"
      chain.add(Prosopite::Middleware::Sidekiq)
    end
  end
end
