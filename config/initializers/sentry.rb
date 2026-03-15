# Sentry config for error tracking via Better Stack
Sentry.init do |config|
  config.dsn = Rails.application.credentials.sentry[:dsn]

  config.breadcrumbs_logger = %i[active_support_logger http_logger]

  config.enabled_environments = %w[production]
end
