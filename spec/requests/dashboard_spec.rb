require "rails_helper"

RSpec.describe "Dashboard", type: :request do
  describe "GET /index" do
    context "when user is guest" do
      before { get "/" }

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when user is signed in" do
      let(:user) { build(:user, first_name: "John", last_name: "Doe") }

      before do
        sign_in user
        get "/"
      end

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
