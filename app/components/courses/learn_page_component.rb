module Courses
  # Course overview page for enrolled users — no purchase UI, all lessons clickable
  class LearnPageComponent < ApplicationViewComponent
    param :course, Types::Instance(Course)
    option :lessons, Types::Array.of(Types::Instance(Lesson))

    delegate :instructor, to: :course

    def progress_percent
      k(course).completion_percentage_for_user(helpers.current_user)
    end
  end
end
