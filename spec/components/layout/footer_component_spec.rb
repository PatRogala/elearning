require "rails_helper"

RSpec.describe Layout::FooterComponent, type: :component do
  it "renders the footer" do
    render_inline(described_class.new)
    expect(page).to have_content("Platform")
      .and have_content("All Courses")
      .and have_content("For Companies")
      .and have_content("About Us")
      .and have_content("Career")
      .and have_content("Contact")
      .and have_content("Manifest")
      .and have_content("Network")
  end
end
