module Instructor
  # New course form component for instructor dashboard
  class CourseFormComponent < ApplicationViewComponent
    param :form, Types::Instance(Teach::CourseForm)

    option :user, Types::Instance(User)

    def render?
      user.teacher?
    end
  end
end
