require "rails_helper"

RSpec.describe DashboardPolicy, type: :policy do
  subject { described_class }

  permissions :index? do
    it { is_expected.to permit(nil, nil) }
  end
end
