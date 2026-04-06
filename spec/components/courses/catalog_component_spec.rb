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

    expect(page).to have_content(courses.first.title)
      .and have_content(courses.first.short_description)
      .and have_content(courses.first.instructor.full_name)
      .and have_content(courses.first.price.format)
      .and have_content(courses.second.title)
      .and have_content(courses.second.short_description)
      .and have_content(courses.second.instructor.full_name)
      .and have_content(courses.second.price.format)
      .and have_content(courses.third.title)
      .and have_content(courses.third.short_description)
      .and have_content(courses.third.instructor.full_name)
      .and have_content(courses.third.price.format)
  end
end
