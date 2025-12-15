module Instructor
  # Allow instructors to edit their courses
  class CourseEditFormComponent < ApplicationViewComponent
    param :form, Types::Instance(Teach::CourseForm)

    option :user, Types::Instance(User)

    delegate :lexxy_rich_textarea_tag, to: :helpers

    def render?
      user.teacher?
    end
  end
end
