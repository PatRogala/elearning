# Base organizer for the application
class ApplicationOrganizer
  extend Dry::Initializer[undefined: false]
  include Interactor::Organizer
end
