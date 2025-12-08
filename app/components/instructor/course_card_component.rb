module Instructor
  # Represents a course card in the instructor dashboard
  class CourseCardComponent < ApplicationViewComponent
    param :course, Types::Instance(Course)

    def published?
      false # TODO: implement
    end

    def description
      "" # TODO: implement
    end

    def students_count
      50 # TODO: implement
    end

    def course_duration
      "50h" # TODO: implement
    end
  end
end
