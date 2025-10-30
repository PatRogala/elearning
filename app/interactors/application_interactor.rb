# Base interactor for the application
class ApplicationInteractor
  extend Dry::Initializer[undefined: false]
  include Interactor
end
