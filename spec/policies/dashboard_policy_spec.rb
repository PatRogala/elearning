require "rails_helper"

RSpec.describe DashboardPolicy, type: :policy do
  permissions :index? do
    it "permits access to the dashboard" do
      expect(described_class).to permit(nil, nil)
    end
  end
end
