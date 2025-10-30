# Preview for the HeaderComponent
class HeaderComponentPreview < ViewComponent::Preview
  def with_user
    render(HeaderComponent.new(current_user: FactoryBot.build(:user)))
  end

  def without_user
    render(HeaderComponent.new(current_user: nil))
  end
end
