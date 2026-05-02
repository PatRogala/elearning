require "rails_helper"

RSpec.describe Ui::FooterComponent, type: :component do
  it "renders the footer" do
    render_inline(described_class.new)
    expect(page).to have_text("Courses")
      .and have_text("Projects")
      .and have_text("Manifesto")
      .and have_text("Legal")
      .and have_text("Privacy Policy")
      .and have_text("Terms of Service")
      .and have_text("Cookie Policy")
      .and have_text("Made with 💖 by Szkoleo")
  end
end
