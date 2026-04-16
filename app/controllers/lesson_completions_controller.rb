# We track lesson completions to determine if a user has completed a course
class LessonCompletionsController < ApplicationController
  before_action :authenticate_user!

  def create
    @course = Course.published.friendly.find(params[:course_id])
    @lesson = @course.lessons.friendly.find(params[:lesson_id])
    authorize(@lesson, :show?)

    current_user.lesson_completions.find_or_create_by!(lesson: @lesson)

    head :ok
  end
end
