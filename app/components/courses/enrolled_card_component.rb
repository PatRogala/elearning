module Courses
  # Card component for an enrolled course with a (stubbed) progress bar
  class EnrolledCardComponent < ApplicationViewComponent
    param :course, Types::Instance(Course)

    delegate :title, :short_description, :instructor, to: :course

    # Stubbed until real progress tracking is implemented
    def progress_percent
      0
    end
  end
end
