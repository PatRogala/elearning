module Teach
  # Controller for teaching courses
  class CoursesController < ApplicationController
    before_action :authenticate_user!

    def new
      course = Course.new
      @form = Teach::CourseForm.new(course)
      authorize([:instructor, course])
    end

    def edit
      course = policy_scope([:instructor, Course]).find(params[:id])
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

    def update
      course = policy_scope([:instructor, Course]).find(params[:id])
      @form = Teach::CourseForm.new(course)
      authorize([:instructor, course])

      if @form.validate(course_params)
        @form.save
        redirect_to edit_teach_course_path(course), notice: t("flash.course.updated")
      else
        flash[:alert] = @form.errors.full_messages.join(", ")
        redirect_to edit_teach_course_path(course)
      end
    end

    private

    def course_params
      params.expect(course: %i[title image description])
    end
  end
end
