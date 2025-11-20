module Ui
  # Preview for the Ui::FlashMessageComponent
  class FlashMessageComponentPreview < ViewComponent::Preview
    def with_success_message
      render(Ui::FlashMessageComponent.new(type: :success, message: "Hello"))
    end

    def with_error_message
      render(Ui::FlashMessageComponent.new(type: :error, message: "Hello"))
    end

    def with_other_message
      render(Ui::FlashMessageComponent.new(type: :info, message: "Hello"))
    end
  end
end
