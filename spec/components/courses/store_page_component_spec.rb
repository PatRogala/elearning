require "rails_helper"

RSpec.describe Courses::StorePageComponent, type: :component do
  it "renders the store page" do
    course = create(:course, description: "We will learn how to build a web application using Ruby on Rails.")
    render_inline(described_class.new(course))

    expect(page).to have_text(course.title)
      .and have_text(course.description.to_plain_text)
      .and have_text(course.instructor.full_name)
      .and have_text("Free")
  end
end
