source "https://rubygems.org"

# Bundle edge Rails instead: gem "rails", github: "rails/rails", branch: "main"
gem "rails"
# The modern asset pipeline for Rails [https://github.com/rails/propshaft]
gem "propshaft"
# Use postgresql as the database for Active Record
gem "pg"
# Use the Puma web server [https://github.com/puma/puma]
gem "puma"
# Bundle and transpile JavaScript [https://github.com/rails/jsbundling-rails]
gem "jsbundling-rails"
# Hotwire's SPA-like page accelerator [https://turbo.hotwired.dev]
gem "turbo-rails"
# Hotwire's modest JavaScript framework [https://stimulus.hotwired.dev]
gem "stimulus-rails"
# Bundle and process CSS [https://github.com/rails/cssbundling-rails]
gem "cssbundling-rails"

# Windows does not include zoneinfo files, so bundle the tzinfo-data gem
gem "tzinfo-data", platforms: %i[windows jruby]

# Use the database-backed adapters for Rails.cache
gem "solid_cache"

# Reduces boot times through caching; required in config/boot.rb
gem "bootsnap", require: false

# Deploy this application anywhere as a Docker container [https://kamal-deploy.org]
gem "kamal", require: false

# Add HTTP asset caching/compression and X-Sendfile acceleration to Puma [https://github.com/basecamp/thruster/]
gem "thruster", require: false

# Background job processing
gem "sidekiq"

# Authentication framework
gem "devise"
gem "devise-i18n"

# A framework for creating reusable, testable & encapsulated view components
gem "view_component"

# Dry family
gem "dry-initializer" # A simple way to create initializer methods
gem "dry-types" # Type system for Ruby
gem "dry-validation" # Validation for Ruby (ReForm)

# Lograge for 1-line logging
gem "lograge"

# Interactor for business logic
gem "interactor-rails"

# Haml for HTML templates
gem "haml-rails"

# Catch unsafe migrations in development
gem "strong_migrations"

# Internationalization for Rails
gem "rails-i18n"

# Find N+1 queries
gem "pg_query"
gem "prosopite"

# PGHero for database monitoring
gem "pghero"

# Lucide Icons for Rails
gem "lucide-rails"

# Avo as admin framework
gem "avo"

# Reform for form objects
gem "reform-rails"

# Authorization framework
gem "pundit"

# Lexxy as a new editor for action text
gem "lexxy", "~> 0.1.26.beta"

# Validations for storage objects
gem "active_storage_validations"
gem "image_processing"
gem "ruby-vips"

# Money for handling currency
gem "money-rails"

# AWS SDK for S3
gem "aws-sdk-s3", require: false

group :development, :test do
  # See https://guides.rubyonrails.org/debugging_rails_applications.html#debugging-with-the-debug-gem
  gem "debug", platforms: %i[mri windows], require: "debug/prelude"

  # Static analysis for security vulnerabilities [https://brakemanscanner.org/]
  gem "brakeman", require: false

  # Audit gem vulnerabilities [https://github.com/rubysec/bundler-audit]
  gem "bundler-audit", require: false

  # Load environment variables from .env file
  gem "dotenv-rails"

  # Rubocop for code style
  gem "rubocop", require: false
  gem "rubocop-capybara", require: false
  gem "rubocop-factory_bot", require: false
  gem "rubocop-performance", require: false
  gem "rubocop-rails", require: false
  gem "rubocop-rspec", require: false
  gem "rubocop-rspec_rails", require: false

  # Avoid various issues due to inconsistencies and inefficiencies between a database schema and application models
  gem "database_consistency", require: false

  # Detect inconsistencies between a database schema and application models
  gem "active_record_doctor"

  # Rspec as a testing framework
  gem "rspec-rails"

  # Capybara for feature and system tests
  gem "capybara"

  # HTML to Haml converter
  gem "html2haml"

  # Factories for database seeding
  gem "factory_bot_rails"

  # Faker for generating fake data
  gem "faker"

  # Debugger for Ruby
  gem "byebug"

  # I18n tasks for translations management
  gem "i18n-tasks"
end

group :development do
  # Use console on exceptions pages [https://github.com/rails/web-console]
  gem "web-console"

  # Lookbook for UI development
  gem "lookbook"
end

group :test do
  # Sidekiq testing helpers
  gem "rspec-sidekiq"

  # Code coverage for tests
  gem "simplecov", require: false

  # one-liners to test common Rails functionality that
  gem "shoulda-matchers"

  # Clean up the database between tests
  gem "database_cleaner-active_record"

  # Cucumber for acceptance tests
  gem "cucumber-rails", require: false

  # Mock HTTP requests
  gem "webmock"

  # Record and replay HTTP requests
  gem "vcr"

  # W3C HTML validation
  gem "w3c_validators"
end
