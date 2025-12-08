module Instructor
  # New course form component for instructor dashboard
  class CourseFormComponent < ApplicationViewComponent
    param :course, Types::Instance(Course)

    option :user, Types::Instance(User)

    def render?
      user.teacher?
    end
  end
end
