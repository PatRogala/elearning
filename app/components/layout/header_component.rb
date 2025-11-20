module Layout
  # Header visible on every page
  class HeaderComponent < ApplicationViewComponent
    option :user, Types::Instance(User).optional

    option :sticky, Types::Bool, default: -> { true }

    private

    def app_name
      Constants::APPLICATION_NAME
    end
  end
end
