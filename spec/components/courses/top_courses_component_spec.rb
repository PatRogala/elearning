require "rails_helper"

RSpec.describe Courses::TopCoursesComponent, type: :component do
  before do
    Prosopite.pause
    create_list(:course, 6, :published)
    Prosopite.resume
  end

  it "renders the component" do
    render_inline(described_class.new)
    expect(page).to have_content("Newest courses")
      .and have_content("Browse all courses")
      .and have_content("Instructor:")
      .and have_content("Start learning")
  end
end
