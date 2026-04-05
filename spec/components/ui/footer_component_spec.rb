require "rails_helper"

RSpec.describe Ui::FooterComponent, type: :component do
  it "renders the footer" do
    render_inline(described_class.new)
    expect(page).to have_content("Courses")
      .and have_content("Projects")
      .and have_content("Manifesto")
      .and have_content("Legal")
      .and have_content("Privacy Policy")
      .and have_content("Terms of Service")
      .and have_content("Cookie Policy")
      .and have_content("Made with 💖 by Szkoleo")
  end

  # it "renders something useful" do
  #   expect(
  #     render_inline(described_class.new(attr: "value")) { "Hello, components!" }.css("p").to_html
  #   ).to include(
  #     "Hello, components!"
  #   )
  # end
end
