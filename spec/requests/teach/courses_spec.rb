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

      before do
        allow(user).to receive(:teacher?).and_return(true)
        sign_in(user)
        get new_teach_course_path
      end

      it_behaves_like "valid HTML"

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "POST /create" do
    context "when user is not authenticated" do
      it "redirects to login" do
        post teach_courses_path
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is not teacher" do
      let(:user) { create(:user) }

      it "redirects to root" do
        sign_in(user)
        post teach_courses_path
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user is teacher" do
      let(:user) { create(:user) }

      before do
        allow(user).to receive(:teacher?).and_return(true)
        sign_in(user)
      end

      context "when course is valid" do
        before do
          post teach_courses_path, params: { course: { title: "Test Course" } }
        end

        it "redirects to dashboard" do
          expect(response).to redirect_to(teach_dashboard_path)
        end

        it "sets a success flash message" do
          expect(flash[:notice]).to eq(I18n.t("flash.course.created"))
        end

        it "creates a new course" do
          expect(Course.first).to have_attributes(title: "Test Course")
            .and have_attributes(instructor: user)
        end
      end
    end
  end
end
