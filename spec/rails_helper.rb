# Check code coverage for tests
require "simplecov"
SimpleCov.start "rails" do
  add_filter "app/previews"
  add_filter "app/avo"
  add_filter "app/controllers/avo"

  add_group "Interactors", "app/interactors"
  add_group "Policies", "app/policies"
  add_group "Components", "app/components"
  add_group "Forms", "app/forms"
end

require "spec_helper"
ENV["RAILS_ENV"] = "test"
require_relative "../config/environment"

# Prevent database truncation if the environment is production
abort("The Rails environment is running in production mode!") if Rails.env.production?
require "rspec/rails"

# Add additional requires below this line. Rails is not loaded until this point!
require "capybara/rails"
require "capybara/rspec"
require "view_component/test_helpers"
require "webmock/rspec"
require "pundit/rspec"

# Check shared examples for easy to use common testing patterns for various Rails features
Rails.root.glob("spec/support/**/*.rb").sort_by(&:to_s).each { |f| require f }

begin
  ActiveRecord::Migration.maintain_test_schema!
rescue ActiveRecord::PendingMigrationError => e
  abort e.to_s.strip
end
RSpec.configure do |config|
  # Remove this line if you're not using ActiveRecord or ActiveRecord fixtures
  config.fixture_paths = [
    Rails.root.join("spec/fixtures")
  ]

  # If you're not using ActiveRecord, or you'd prefer not to run each of your
  # examples within a transaction, remove the following line or assign false
  # instead of true.
  config.use_transactional_fixtures = true

  # Filter lines from Rails gems in backtraces.
  config.filter_rails_from_backtrace!
  # arbitrary gems may also be filtered via:
  config.filter_gems_from_backtrace("view_component", "database_cleaner", "webmock")

  # Include helpers for extra testing functionality
  config.include ViewComponent::TestHelpers, type: :component
  config.include ViewComponent::SystemSpecHelpers, type: :feature
  config.include ViewComponent::SystemSpecHelpers, type: :system
  config.include Capybara::RSpecMatchers, type: :component
  config.include FactoryBot::Syntax::Methods
  config.include Devise::Test::IntegrationHelpers, type: :request
end

RSpec::Sidekiq.configure do |config|
  # Disable warnings from Sidekiq
  config.warn_when_jobs_not_processed_by_sidekiq = false
end

# Configure shoulda-matchers for one-liner testing
Shoulda::Matchers.configure do |config|
  config.integrate do |with|
    with.test_framework :rspec
    with.library :rails
  end
end
