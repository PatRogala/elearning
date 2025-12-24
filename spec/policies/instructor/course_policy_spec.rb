require "rails_helper"

RSpec.describe Instructor::CoursePolicy, type: :policy do
  subject(:policy) { described_class }

  let(:scope) { Instructor::CoursePolicy::Scope.new(user, Course).resolve }
  let(:user) { create(:user) }

  permissions ".scope" do
    it "returns all courses created by user" do
      course = create(:course, instructor: user)
      expect(scope).to contain_exactly(course)
    end
  end

  permissions :index?, :create?, :new? do
    before do
      allow(user).to receive(:teacher?).and_return(true)
    end

    it { is_expected.to permit(user, Course) }
  end

  permissions :edit?, :publish?, :update? do
    let(:course) { create(:course, instructor: user) }

    before do
      allow(user).to receive(:teacher?).and_return(true)
    end

    it { is_expected.to permit(user, course) }
  end
end
