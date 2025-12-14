require "rails_helper"

RSpec.describe Instructor::CourseEditFormComponent, type: :component do
  let(:course) { build(:course, id: 1) }
  let(:user) { build(:user) }
  let(:form) { Teach::CourseForm.new(course) }

  before do
    allow(user).to receive(:teacher?).and_return(true)
  end

  it "renders the form" do
    render_inline(described_class.new(form, user: user))

    expect(page).to have_content("Title")
      .and have_content("Description")
      .and have_content("Course Cover")
      .and have_content("Price")
  end
end
