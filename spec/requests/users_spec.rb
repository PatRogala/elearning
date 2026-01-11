require "rails_helper"

RSpec.describe "Users", type: :request do
  describe "PATCH /update" do
    let(:user) { create(:user) }

    before { sign_in(user) }

    context "when params are valid and user is editing own profile" do
      it "updates user" do
        patch user_path(id: user.id), params: { user: { first_name: "John" } }
        expect(user.reload.first_name).to eq("John")
      end
    end

    context "when params are invalid" do
      it "does not update user" do
        patch user_path(id: user.id), params: { user: { first_name: "" } }
        expect(user.reload.first_name).not_to be_empty
      end
    end
  end
end
