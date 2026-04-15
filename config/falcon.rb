# Falcon web server configuration
#
# Development: HTTPS on localhost:3000 using self-signed certificates from the localhost gem.
#   Browser access: https://localhost:3000
#   Run `bundle exec bake localhost:install` locally (on your Mac, not in Docker) to
#   trust the certificate in the macOS Keychain — dip provision does this automatically.
#
# Production: HTTP on 0.0.0.0:3000, TLS terminated by Kamal proxy (Let's Encrypt).

load :rack, :supervisor

if ENV.fetch("RAILS_ENV", "development") == "production"
  service "web" do
    include Falcon::Environment::Rack

    endpoint do
      Async::HTTP::Endpoint.parse("http://0.0.0.0:#{ENV.fetch('PORT', '3000')}")
    end

    count { ENV.fetch("WEB_CONCURRENCY", "1").to_i }
  end
else
  service "localhost" do
    # SelfSignedTLS provides ssl_context using the localhost gem for the service name ("localhost")
    include Falcon::Environment::SelfSignedTLS
    include Falcon::Environment::Rack

    # Bind to 0.0.0.0 (all interfaces) so Docker port mapping works.
    # The TLS certificate is for "localhost" — browsers connecting to https://localhost:3000
    # will trust it once the cert is installed via `bundle exec bake localhost:install`.
    endpoint do
      Async::HTTP::Endpoint.parse("https://0.0.0.0:3000").with(
        ssl_context: ssl_context
      )
    end

    count { ENV.fetch("WEB_CONCURRENCY", "1").to_i }
  end
end
