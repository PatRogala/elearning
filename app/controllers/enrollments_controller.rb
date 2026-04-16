# Handles course enrollment for authenticated users
class EnrollmentsController < ApplicationController
  before_action :authenticate_user!

  def create
    @course = Course.friendly.find(params[:course_id])
    authorize Enrollment

    result = Enrollments::Create.call(user: current_user, course: @course)

    if result.success?
      redirect_to course_path(@course), notice: t("flash.enrollment.created")
    else
      redirect_to course_path(@course), alert: result.message
    end
  end
end
