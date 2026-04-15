require "rails_helper"

RSpec.describe Instructor::CourseEditFormComponent, type: :component do
  let(:course) { build(:course, id: 1) }
  let(:user) { build(:user) }
  let(:form) { Teach::CourseForm.new(course) }

  before do
    allow(user).to receive(:teacher?).and_return(true)
    course.image.purge
  end

  it "renders the form" do
    render_inline(described_class.new(form, user: user))

    expect(page).to have_content("Course title")
      .and have_content("Course description")
      .and have_content("Course cover")
      .and have_content("Price")
  end
end
