# Preview for the Misc::LocaleSelectorComponent
class LocaleSelectorComponentPreview < ViewComponent::Preview
  def for_polish_user
    render(Misc::LocaleSelectorComponent.new(user_locale: :pl))
  end

  def for_english_user
    render(Misc::LocaleSelectorComponent.new(user_locale: :en))
  end

  def for_other_locale
    render(Misc::LocaleSelectorComponent.new(user_locale: :de))
  end

  def for_mobile_user
    render(Misc::LocaleSelectorComponent.new(user_locale: :pl, mobile_version: true))
  end
end
