require "rails_helper"

RSpec.describe Courses::CardComponent, type: :component do
  it "renders course card" do
    course = create(:course)
    render_inline(described_class.new(course))

    expect(page).to have_content(course.title)
      .and have_content(course.short_description)
      .and have_content(course.instructor.full_name)
      .and have_content(course.price.format)
  end
end
