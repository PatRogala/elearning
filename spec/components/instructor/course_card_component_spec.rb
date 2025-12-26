require "rails_helper"

RSpec.describe Instructor::CourseCardComponent, type: :component do
  let(:course) { build(:course, id: 1, image: nil) }

  it "renders course card" do
    render_inline(described_class.new(course))

    expect(page).to have_content(course.title)
      .and have_content("Draft")
  end
end
