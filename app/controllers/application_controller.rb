# Base controller for the application
class ApplicationController < ActionController::Base
  include Pundit::Authorization

  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  before_action :configure_permitted_parameters, if: :devise_controller?
  after_action :verify_authorized, unless: :devise_controller?
  around_action :switch_locale

  # Only allow modern browsers supporting webp images, web push, badges, import maps, CSS nesting, and CSS :has.
  allow_browser versions: :modern

  private

  def switch_locale(&)
    locale = params[:locale] || I18n.default_locale
    I18n.with_locale(locale, &)
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def user_not_authorized
    flash[:alert] = t("flash.unauthorized")
    redirect_to(request.referer || root_path)
  end

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[first_name last_name])
  end
end
