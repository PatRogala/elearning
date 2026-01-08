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

  describe "GET /edit" do
    let(:course) { create(:course) }

    context "when user is not authenticated" do
      it "redirects to login" do
        get edit_teach_course_path(id: course.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is teacher" do
      let(:user) { create(:user) }
      let(:course) { create(:course, instructor: user, title: "Test Course", id: 1) }

      before do
        allow(user).to receive(:teacher?).and_return(true)
        course.image.purge
        sign_in(user)
        get edit_teach_course_path(id: course.id)
      end

      it_behaves_like "valid HTML"

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH /update" do
    let(:course) { create(:course) }

    context "when user is not authenticated" do
      it "redirects to login" do
        patch teach_course_path(id: course.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is teacher" do
      let(:user) { create(:user) }
      let(:course) { create(:course, instructor: user) }

      before do
        allow(user).to receive(:teacher?).and_return(true)
        sign_in(user)
      end

      context "when params are valid" do
        before do
          patch teach_course_path(id: course.id), params: { course: { title: "Updated Title" } }
        end

        it "redirects to edit page" do
          expect(response).to redirect_to(edit_teach_course_path(course))
        end

        it "sets a success flash message" do
          expect(flash[:notice]).to eq(I18n.t("flash.course.updated"))
        end

        it "updates the course" do
          expect(course.reload.title).to eq("Updated Title")
        end
      end

      context "when params are invalid" do
        before do
          patch teach_course_path(id: course.id), params: { course: { title: "" } }
        end

        it "redirects to edit page" do
          expect(response).to redirect_to(edit_teach_course_path(course))
        end

        it "sets an error flash message" do
          expect(flash[:alert]).to be_present
        end

        it "does not update the course" do
          expect(course.reload.title).not_to eq("")
        end
      end
    end
  end

  describe "PATCH /publish" do
    let(:course) { create(:course) }

    context "when user is not authenticated" do
      it "redirects to login" do
        patch teach_course_path(id: course.id)
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is teacher" do
      let(:user) { create(:user) }
      let(:course) { create(:course, instructor: user) }

      before do
        allow(user).to receive(:teacher?).and_return(true)
        sign_in(user)
      end

      context "when params are valid" do
        before do
          course.update(description: "Test Description")
          patch publish_teach_course_path(id: course.id)
        end

        it "redirects to edit page" do
          expect(response).to redirect_to(edit_teach_course_path(course))
        end

        it "sets a success flash message" do
          expect(flash[:notice]).to eq(I18n.t("flash.course.published"))
        end

        it "updates the course" do
          expect(course.reload).to be_published
        end
      end

      context "when params are invalid" do
        before do
          course.image.purge
          patch publish_teach_course_path(id: course.id)
        end

        it "redirects to edit page" do
          expect(response).to redirect_to(edit_teach_course_path(course))
        end

        it "sets an error flash message" do
          expect(flash[:alert]).to be_present
        end

        it "does not update the course" do
          expect(course.reload).not_to be_published
        end
      end
    end
  end
end
