require "rails_helper"

RSpec.describe Instructor::LessonPolicy, type: :policy do
  subject(:policy) { described_class }

  let(:user) { create(:user) }
  let(:course) { create(:course, instructor: user) }
  let(:lesson) { build(:lesson, course: course) }

  permissions :new?, :create? do
    before do
      allow(user).to receive(:teacher?).and_return(true)
    end

    it { is_expected.to permit(user, lesson) }

    context "when the course belongs to another instructor" do
      let(:other_course) { create(:course) }
      let(:lesson) { build(:lesson, course: other_course) }

      it { is_expected.not_to permit(user, lesson) }
    end
  end

  permissions :edit?, :destroy?, :update? do
    before do
      allow(user).to receive(:teacher?).and_return(true)
    end

    it { is_expected.to permit(user, lesson) }

    context "when the course belongs to another instructor" do
      let(:other_course) { create(:course) }
      let(:lesson) { build(:lesson, course: other_course) }

      it { is_expected.not_to permit(user, lesson) }
    end

    context "when user is not a teacher" do
      before do
        allow(user).to receive(:teacher?).and_return(false)
      end

      it { is_expected.not_to permit(user, lesson) }
    end
  end
end
