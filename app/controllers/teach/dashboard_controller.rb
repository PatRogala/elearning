module Teach
  # Dashboard for instructors
  class DashboardController < ApplicationController
    before_action :authenticate_user!

    def index
      authorize(%i[instructor Course])
    end
  end
end
