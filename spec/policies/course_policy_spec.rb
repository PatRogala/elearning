require "rails_helper"

RSpec.describe CoursePolicy, type: :policy do
  subject { described_class }

  let(:scope) { CoursePolicy::Scope.new(user, Course).resolve }

  let(:user) { create(:user) }

  permissions ".scope" do
    before do
      Prosopite.pause
      create_list(:course, 3, :published)
      Prosopite.resume
    end

    it "returns all published courses" do
      expect(scope).to match_array(Course.all)
    end
  end

  permissions :index? do
    it { is_expected.to permit(user, Course) }
  end
end
