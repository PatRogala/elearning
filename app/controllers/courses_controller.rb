# Allows users to view courses
class CoursesController < ApplicationController
  before_action :authenticate_user!, only: :enrolled

  def index
    @courses = policy_scope(Course)
    authorize(@courses)
  end

  def show
    @course = policy_scope(Course).friendly.find(params[:id])
    authorize(@course)
    @enrolled = current_user.present? && current_user.enrollments.exists?(course: @course)
  end

  def enrolled
    @courses = current_user.enrolled_courses
                           .published
                           .recent
                           .with_attached_image
                           .with_rich_text_description
                           .includes(instructor: { avatar_attachment: :blob })
    authorize(@courses, :enrolled?)
  end
end
