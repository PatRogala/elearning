ENV["SKYLIGHT_AUTHENTICATION"] ||= Rails.application.credentials.dig(:skylight, :authentication)
