module Layout
  # Preview for the HeaderComponent
  class HeaderComponentPreview < ViewComponent::Preview
    def with_user
      render(Layout::HeaderComponent.new(user: FactoryBot.build(:user)))
    end

    def without_user
      render(Layout::HeaderComponent.new(user: nil))
    end
  end
end
