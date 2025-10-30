require "rails_helper"

RSpec.describe Misc::LocaleSelectorComponent, type: :component do
  describe "desktop rendering" do
    it "renders locale selector dropdown with current locale" do
      component = render_inline(described_class.new(user_locale: :pl))

      expect(component).to have_css(".locale-selector")
        .and have_text("Polski")
        .and have_text("🇵🇱")
    end

    it "shows current locale in button" do
      component = render_inline(described_class.new(user_locale: :en))

      button = component.css("button")
      expect(button).to have_text("English").and have_text("🇺🇸")
    end

    it "shows other locales in dropdown" do
      component = render_inline(described_class.new(user_locale: :en))

      dropdown_links = component.css(".absolute a")
      expect(dropdown_links).to have_text("Polski").and have_text("🇵🇱")
    end

    it "generates correct URLs for locale switching" do
      component = render_inline(described_class.new(user_locale: :pl))

      links = component.css("a")
      expect(links.first["href"]).to eq("/en")
    end

    it "includes Stimulus controller data attributes" do
      component = render_inline(described_class.new(user_locale: :pl))

      expect(component).to have_css('[data-controller="locale-dropdown"]')
        .and have_css('[data-action="click->locale-dropdown#toggle"]')
        .and have_css('[data-locale-dropdown-target="button"]')
        .and have_css('[data-locale-dropdown-target="menu"]')
    end
  end

  describe "mobile rendering" do
    it "renders mobile locale selector" do
      component = described_class.new(user_locale: :pl, mobile_version: true)
      rendered = render_inline(component)

      expect(rendered.css(".locale-selector-mobile")).to be_present
        .and have_text("Polski")
        .and have_text("English")
        .and have_text("🇵🇱")
        .and have_text("🇺🇸")
    end

    it "highlights current locale in mobile version" do
      component = described_class.new(user_locale: :en, mobile_version: true)
      rendered = render_inline(component)

      # Current locale should be highlighted
      highlighted = rendered.css(".bg-gray-100")
      expect(highlighted.text).to include("English").and include("🇺🇸")
    end

    it "does not include dropdown functionality in mobile version" do
      component = described_class.new(user_locale: :pl, mobile_version: true)
      rendered = render_inline(component)

      expect(rendered.css('[data-controller="locale-dropdown"]')).to be_empty
    end
  end
end
