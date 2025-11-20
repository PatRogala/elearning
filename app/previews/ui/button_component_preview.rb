module Ui
  # Preview for the Ui::ButtonComponent
  class ButtonComponentPreview < ViewComponent::Preview
    def default
      render(Ui::ButtonComponent.new(label: "Default", href: "#"))
    end

    def danger
      render(Ui::ButtonComponent.new(label: "Danger", href: "#", scheme: :danger))
    end
  end
end
