require "rails_helper"

RSpec.describe Courses::CategoriesCalloutComponent, type: :component do
  it "renders categories callout grid" do
    render_inline(described_class.new)

    expect(page).to have_text("Choose your path")
      .and have_text("Time for something new?")
      .and have_text("Backend")
      .and have_text("Frontend")
      .and have_text("UI / UX")
      .and have_text("DevOps")
      .and have_text("Coming soon")
  end
end
