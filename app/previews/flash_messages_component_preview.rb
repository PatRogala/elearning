# Preview for the Misc::FlashMessagesComponent
class FlashMessagesComponentPreview < ViewComponent::Preview
  def with_success_message
    render(Misc::FlashMessagesComponent.new(flash: { success: "Hello" }))
  end

  def with_error_message
    render(Misc::FlashMessagesComponent.new(flash: { error: "Hello" }))
  end

  def with_warning_message
    render(Misc::FlashMessagesComponent.new(flash: { warning: "Hello" }))
  end

  def with_other_message
    render(Misc::FlashMessagesComponent.new(flash: { other: "Hello" }))
  end
end
