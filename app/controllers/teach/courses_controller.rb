module Teach
  # Controller for teaching courses
  class CoursesController < ApplicationController
    before_action :authenticate_user!

    def new
      course = Course.new
      @form = Teach::CourseForm.new(course)
      authorize([:instructor, course])
    end

    def create
      course = Course.new(instructor: current_user)
      @form = Teach::CourseForm.new(course)
      authorize([:instructor, course])

      if @form.validate(course_params)
        @form.save
        redirect_to teach_dashboard_path, notice: t("flash.course.created")
      else
        flash[:alert] = @form.errors.full_messages.join(", ")
        redirect_to new_teach_course_path
      end
    end

    private

    def course_params
      params.expect(teach_course: %i[title])
    end
  end
end
