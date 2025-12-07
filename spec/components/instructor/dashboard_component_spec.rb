require "rails_helper"

RSpec.describe Instructor::DashboardComponent, type: :component do
  let(:user) { build(:user) }

  before do
    allow(user).to receive(:teacher?).and_return(true)
  end

  it "renders dashboard" do
    render_inline(described_class.new(user: user))

    expect(page).to have_content("Your Courses")
  end
end
