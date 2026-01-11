require "rails_helper"

RSpec.describe UserPolicy, type: :policy do
  subject { described_class }

  let(:user) { create(:user) }

  permissions :update? do
    let(:course) { create(:course, instructor: user) }

    it { is_expected.to permit(user, user) }
    it { is_expected.not_to permit(user, create(:user)) }
  end
end
