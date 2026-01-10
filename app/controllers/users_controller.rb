class UsersController < ApplicationController
  before_action :authenticate_user!

  def update
    authorize(current_user)

    if current_user.update(user_params)
      redirect_to edit_user_registration_path, notice: t("flash.user.updated")
    else
      redirect_to edit_user_registration_path, alert: current_user.errors.full_messages.join(", ")
    end
  end

  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :bio, :avatar)
  end
end
