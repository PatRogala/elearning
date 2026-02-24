require "rails_helper"

RSpec.describe Courses::CategoriesCalloutComponent, type: :component do
  it "renders categories callout grid" do
    render_inline(described_class.new)

    expect(page).to have_css("Choose your path")
      .and have_css("Time for something new?")
      .and have_css("Backend")
      .and have_css("Frontend")
      .and have_css("UI / UX")
      .and have_css("DevOps")
      .and have_css("Coming soon")
  end
end
