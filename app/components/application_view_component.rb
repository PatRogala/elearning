# Base view component for the application
class ApplicationViewComponent < ViewComponent::Base
  extend Dry::Initializer[undefined: false]

  # Dry types for the component
  module Types
    include Dry.Types()
  end

  # Lucide Icons helper
  delegate :lucide_icon, to: :helpers
end
