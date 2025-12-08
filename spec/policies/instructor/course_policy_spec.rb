require "rails_helper"

RSpec.describe Instructor::CoursePolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }

  permissions ".scope" do
    pending "add some examples to (or delete) #{__FILE__}"
  end

  permissions :index?, :create?, :new? do
    before do
      allow(user).to receive(:teacher?).and_return(true)
    end

    it { is_expected.to permit(user, Course) }
  end
end
