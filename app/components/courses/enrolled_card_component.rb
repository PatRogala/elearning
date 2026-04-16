module Courses
  # Card component for an enrolled course with a (stubbed) progress bar
  class EnrolledCardComponent < ApplicationViewComponent
    param :course, Types::Instance(Course)

    delegate :title, :short_description, :instructor, to: :course

    def progress_percent
      k(course).completion_percentage_for_user(helpers.current_user)
    end
  end
end
