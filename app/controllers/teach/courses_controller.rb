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
      # TODO: Implement
    end

    private

    def course_params
      params.expect(course: %i[title])
    end
  end
end
