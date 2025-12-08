require "rails_helper"

RSpec.describe "Teach::Courses", type: :request do
  describe "GET /new" do
    context "when user is not authenticated" do
      it "redirects to login" do
        get new_teach_course_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is not teacher" do
      let(:user) { create(:user) }

      it "redirects to root" do
        sign_in(user)
        get new_teach_course_path
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user is teacher" do
      let(:user) { create(:user) }

      it_behaves_like "valid HTML"

      it "returns http success" do
        allow(user).to receive(:teacher?).and_return(true)
        sign_in(user)
        get new_teach_course_path
        expect(response).to have_http_status(:success)
      end
    end
  end
end
