# A root view for the application
class DashboardController < ApplicationController
  def index
    authorize :dashboard, :index?
  end
end
