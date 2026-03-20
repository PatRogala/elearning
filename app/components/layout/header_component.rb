module Layout
  # Header visible on every page
  class HeaderComponent < ApplicationViewComponent
    option :user, Types::Instance(User).optional

    option :sticky, Types::Bool, default: -> { true }
  end
end
