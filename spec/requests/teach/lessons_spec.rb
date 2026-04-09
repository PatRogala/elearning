require "rails_helper"

RSpec.describe "Teach::Lessons", type: :request do
  let(:user) { create(:user, first_name: "John", last_name: "Doe") }
  let(:course) { create(:course, instructor: user, title: "Intro to Rails") }

  describe "GET /new" do
    context "when user is not authenticated" do
      it "redirects to login" do
        get "/teach/courses/#{course.id}/lessons/new"
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is not teacher" do
      it "redirects to root" do
        sign_in(user)
        get "/teach/courses/#{course.id}/lessons/new"
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user is teacher" do
      before do
        allow(user).to receive(:teacher?).and_return(true)
        sign_in(user)
        get "/teach/courses/#{course.id}/lessons/new"
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
        post "/teach/courses/#{course.id}/lessons"
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is not teacher" do
      it "redirects to root" do
        sign_in(user)
        post "/teach/courses/#{course.id}/lessons"
        expect(response).to redirect_to(root_path)
      end
    end

    context "when user is teacher" do
      before do
        allow(user).to receive(:teacher?).and_return(true)
        sign_in(user)
      end

      context "when params are valid" do
        before do
          post "/teach/courses/#{course.id}/lessons", params: { lesson: { title: "Intro to Rails" } }
        end

        it "redirects to course edit page" do
          expect(response).to redirect_to(edit_teach_course_path(course))
        end

        it "sets a success flash message" do
          expect(flash[:notice]).to eq(I18n.t("flash.lesson.created"))
        end

        it "creates a new lesson" do
          expect(course.lessons.first).to have_attributes(title: "Intro to Rails")
        end

        it "auto-assigns position 1 for the first lesson" do
          expect(course.lessons.first.position).to eq(1)
        end
      end

      context "when a lesson already exists" do
        before do
          create(:lesson, course: course, position: 1)
          post "/teach/courses/#{course.id}/lessons", params: { lesson: { title: "Second Lesson" } }
        end

        it "assigns the next position" do
          expect(course.lessons.find_by(title: "Second Lesson").position).to eq(2)
        end
      end

      context "when params are invalid" do
        before do
          post "/teach/courses/#{course.id}/lessons", params: { lesson: { title: "" } }
        end

        it "redirects to new lesson page" do
          expect(response).to redirect_to(new_teach_course_lesson_path(course))
        end

        it "sets an error flash message" do
          expect(flash[:alert]).to be_present
        end

        it "does not create a lesson" do
          expect(course.lessons).to be_empty
        end
      end
    end
  end

  describe "GET /edit" do
    let(:lesson) { create(:lesson, course: course, position: 1, title: "Intro to Rails", id: 1) }

    context "when user is not authenticated" do
      it "redirects to login" do
        get "/teach/courses/#{course.id}/lessons/#{lesson.id}/edit"
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is teacher" do
      before do
        allow(user).to receive(:teacher?).and_return(true)
        sign_in(user)
        get "/teach/courses/#{course.id}/lessons/#{lesson.id}/edit"
      end

      it_behaves_like "valid HTML"

      it "returns http success" do
        expect(response).to have_http_status(:success)
      end
    end
  end

  describe "PATCH /update" do
    let(:lesson) { create(:lesson, course: course, position: 1) }

    context "when user is not authenticated" do
      it "redirects to login" do
        patch "/teach/courses/#{course.id}/lessons/#{lesson.id}"
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is teacher" do
      before do
        allow(user).to receive(:teacher?).and_return(true)
        sign_in(user)
      end

      context "when params are valid" do
        before do
          patch "/teach/courses/#{course.id}/lessons/#{lesson.id}", params: { lesson: { title: "Updated Title" } }
        end

        it "redirects to course edit page" do
          expect(response).to redirect_to(edit_teach_course_path(course))
        end

        it "sets a success flash message" do
          expect(flash[:notice]).to eq(I18n.t("flash.lesson.updated"))
        end

        it "updates the lesson" do
          expect(lesson.reload.title).to eq("Updated Title")
        end
      end

      context "when params are invalid" do
        before do
          patch "/teach/courses/#{course.id}/lessons/#{lesson.id}", params: { lesson: { title: "" } }
        end

        it "redirects to edit lesson page" do
          expect(response).to redirect_to(edit_teach_course_lesson_path(course, lesson))
        end

        it "sets an error flash message" do
          expect(flash[:alert]).to be_present
        end

        it "does not update the lesson" do
          expect(lesson.reload.title).not_to eq("")
        end
      end
    end
  end

  describe "DELETE /destroy" do
    let!(:lesson) { create(:lesson, course: course, position: 1) }

    context "when user is not authenticated" do
      it "redirects to login" do
        delete "/teach/courses/#{course.id}/lessons/#{lesson.id}"
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "when user is teacher" do
      before do
        allow(user).to receive(:teacher?).and_return(true)
        sign_in(user)
      end

      context "when lesson belongs to their course" do
        before do
          delete "/teach/courses/#{course.id}/lessons/#{lesson.id}"
        end

        it "redirects to course edit page" do
          expect(response).to redirect_to(edit_teach_course_path(course))
        end

        it "sets a success flash message" do
          expect(flash[:notice]).to eq(I18n.t("flash.lesson.destroyed"))
        end

        it "deletes the lesson" do
          expect(course.lessons).to be_empty
        end
      end
    end
  end
end
