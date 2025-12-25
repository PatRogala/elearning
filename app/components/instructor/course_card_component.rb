module Instructor
  # Represents a course card in the instructor dashboard
  class CourseCardComponent < ApplicationViewComponent
    param :course, Types::Instance(Course)

    attr_reader :course

    delegate :published?, to: :course
    delegate :description, to: :course

    def students_count
      50 # TODO: implement
    end

    def course_duration
      "50h" # TODO: implement
    end
  end
end
