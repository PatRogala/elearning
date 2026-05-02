require "rails_helper"

RSpec.describe Courses::CatalogComponent, type: :component do
  before do
    Prosopite.pause
    create_list(:course, 3, :published)
    Prosopite.resume
  end

  it "renders the catalog with list of courses" do
    courses = CoursePolicy::Scope.new(nil, Course).resolve

    render_inline(described_class.new(courses.to_a))

    expect(page).to have_text(courses.first.title)
      .and have_text(courses.first.short_description)
      .and have_text(courses.first.instructor.full_name)
      .and have_text(courses.first.price.format)
      .and have_text(courses.second.title)
      .and have_text(courses.second.short_description)
      .and have_text(courses.second.instructor.full_name)
      .and have_text(courses.second.price.format)
      .and have_text(courses.third.title)
      .and have_text(courses.third.short_description)
      .and have_text(courses.third.instructor.full_name)
      .and have_text(courses.third.price.format)
  end
end
