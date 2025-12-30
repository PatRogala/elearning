class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    authorize(current_user)
  end
end
