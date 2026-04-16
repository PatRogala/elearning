# Allows enrolled users to view individual lessons
class LessonsController < ApplicationController
  before_action :authenticate_user!

  def show
    @course = Course.published
                    .includes(instructor: { avatar_attachment: :blob })
                    .friendly.find(params[:course_id])
    @lesson = @course.lessons.with_rich_text_content.friendly.find(params[:id])
    authorize(@lesson)
    @course_lessons = @course.lessons.ordered.to_a
    @completed_lesson_ids = current_user.lesson_completions.where(lesson: @course_lessons).pluck(:lesson_id).to_set
  end
end
