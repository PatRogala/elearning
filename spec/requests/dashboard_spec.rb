require "rails_helper"

RSpec.describe "Dashboard", type: :request do
  describe "GET /index" do
    context "when user is guest" do
      before { get "/" }

      it_behaves_like "valid HTML"

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end

    context "when user is signed in" do
      let(:user) { create(:user) }

      before do
        sign_in user
        get "/"
      end

      it_behaves_like "valid HTML"

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
