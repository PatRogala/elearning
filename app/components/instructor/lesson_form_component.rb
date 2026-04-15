module Instructor
  # New lesson form component for instructor dashboard
  class LessonFormComponent < ApplicationViewComponent
    param :form, Types::Instance(Teach::LessonForm)

    option :user, Types::Instance(User)
    option :course

    delegate :lexxy_rich_textarea_tag, to: :helpers

    def render?
      user.teacher?
    end
  end
end
