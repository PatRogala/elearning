# Sentry config for error tracking via Better Stack
Sentry.init do |config|
  config.dsn = Rails.application.credentials.sentry[:dsn]

  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  # Send 100% of errors; adjust sample_rate for high-traffic apps
  config.traces_sample_rate = 1.0

  config.enabled_environments = %w[production]
end
