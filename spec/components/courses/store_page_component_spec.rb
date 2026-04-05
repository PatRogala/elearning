require "rails_helper"

RSpec.describe Courses::StorePageComponent, type: :component do
  it "renders the store page" do
    course = create(:course)
    render_inline(described_class.new(course))

    expect(page).to have_content(course.title)
      .and have_content(course.description.to_plain_text.truncate(100))
      .and have_content(course.instructor.full_name)
      .and have_content("Free")
  end
end
