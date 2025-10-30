require "rails_helper"

RSpec.describe Misc::FlashMessagesComponent, type: :component do
  describe "rendering" do
    it "renders success flash messages" do
      component = render_inline(described_class.new(flash: { success: "Hello" }))

      expect(component).to have_text("Hello").and have_css(".bg-green-50")
    end

    it "renders error flash messages" do
      component = render_inline(described_class.new(flash: { error: "Hello" }))

      expect(component).to have_text("Hello").and have_css(".bg-red-50")
    end

    it "renders warning flash messages" do
      component = render_inline(described_class.new(flash: { warning: "Hello" }))

      expect(component).to have_text("Hello").and have_css(".bg-yellow-50")
    end

    it "renders other flash messages" do
      component = render_inline(described_class.new(flash: { other: "Hello" }))

      expect(component).to have_text("Hello").and have_css(".bg-blue-50")
    end
  end
end
