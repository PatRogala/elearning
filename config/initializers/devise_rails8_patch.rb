# TODO: Remove this file once Devise 5 is released

return unless Rails.env.test?

require "devise"

# We need to patch old Devise to work with Rails 8
module Devise
  def self.mappings
    Rails.application.try(:reload_routes_unless_loaded)
    @@mappings
  end
end
