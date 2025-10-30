require "rails_helper"

RSpec.describe Role, type: :model do
  it_behaves_like "a valid factory"
  it_behaves_like "a model with presence validation", :name
  it_behaves_like "a model with uniqueness validation", :name

  describe "scopes" do
    describe "admin" do
      it { expect(described_class.admin).to eq(described_class.find_by(name: "Admin")) }
    end

    describe "teacher" do
      it { expect(described_class.teacher).to eq(described_class.find_by(name: "Teacher")) }
    end
  end
end
