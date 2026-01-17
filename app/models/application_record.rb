# Base model for the application
class ApplicationRecord < ActiveRecord::Base
  ACCEPTED_IMAGE_CONTENT_TYPES = %w[image/jpeg image/png image/avif image/webp].freeze

  primary_abstract_class
end
