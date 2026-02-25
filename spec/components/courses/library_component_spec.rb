require "rails_helper"

RSpec.describe Courses::LibraryComponent, type: :component do
  before do
    Prosopite.pause
    create_list(:course, 3, :published)
    Prosopite.resume
  end

  it "renders the library" do
    render_inline(described_class.new)
    expect(page).to have_content(Course.first.title)
      .and have_content(Course.first.description.to_plain_text.truncate(100))
      .and have_content(Course.first.instructor.full_name)
      .and have_content(Course.first.price.format)
  end
end
