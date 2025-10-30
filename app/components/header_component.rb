# Header visible on every page
class HeaderComponent < ApplicationViewComponent
  option :current_user, Types::Instance(User).optional

  private

  attr_reader :current_user

  def user_signed_in?
    current_user.present?
  end

  def locale_selector
    render(Misc::LocaleSelectorComponent.new(user_locale: I18n.locale))
  end

  def mobile_locale_selector
    render(Misc::LocaleSelectorComponent.new(user_locale: I18n.locale, mobile_version: true))
  end
end
