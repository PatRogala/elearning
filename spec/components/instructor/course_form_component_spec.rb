require "rails_helper"

RSpec.describe Instructor::CourseFormComponent, type: :component do
  let(:course) { build(:course) }
  let(:user) { build(:user) }
  let(:form) { Teach::CourseForm.new(course) }

  before do
    allow(user).to receive(:teacher?).and_return(true)
  end

  it "renders the form" do
    render_inline(described_class.new(form, user: user))

    expect(page).to have_text("Give your new course a working title.")
      .and have_text("Course Title")
      .and have_text("Create & Continue")
  end
end
