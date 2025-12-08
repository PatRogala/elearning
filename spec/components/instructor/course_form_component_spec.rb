require "rails_helper"

RSpec.describe Instructor::CourseFormComponent, type: :component do
  let(:course) { build(:course) }
  let(:user) { build(:user) }

  before do
    allow(user).to receive(:teacher?).and_return(true)
  end

  it "renders the form" do
    render_inline(described_class.new(course, user: user))

    expect(page).to have_content("Name your course")
      .and have_content("Give your new course a working title. It represents the first step in your curriculum.")
      .and have_content("Course Title")
      .and have_content("Create & Continue")
  end
end
