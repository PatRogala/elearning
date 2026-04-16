module Instructor
  # Represents a course card in the instructor dashboard
  class CourseCardComponent < ApplicationViewComponent
    param :course, Types::Instance(Course)

    attr_reader :course

    delegate :published?, to: :course
    delegate :short_description, to: :course

    def students_count
      50 # TODO: implement
    end

    def course_duration
      k(course).formatted_total_time_to_complete
    end

    def lessons_count
      course.lessons.count
    end
  end
end
