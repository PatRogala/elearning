# Enable Prosopite to find N+1 queries
unless Rails.env.production?
  require "prosopite/middleware/rack"
  Rails.configuration.middleware.use(Prosopite::Middleware::Rack)
end
