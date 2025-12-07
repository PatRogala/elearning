require "rails_helper"

RSpec.describe "Teach::Dashboards", type: :request do
  describe "GET /index" do
    context "when user is guest" do
      before { get "/teach/dashboard" }

      it "redirects to login" do
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is not a teacher" do
      let(:user) { build(:user) }

      before do
        sign_in user
        get "/teach/dashboard"
      end

      it "redirects to root" do
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user is a teacher" do
      let(:user) { build(:user) }

      before do
        sign_in user
        allow(user).to receive(:teacher?).and_return(true)
        get "/teach/dashboard"
      end

      it_behaves_like "valid HTML"

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end
end
