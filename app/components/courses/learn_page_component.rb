module Courses
  # Course overview page for enrolled users — no purchase UI, all lessons clickable
  class LearnPageComponent < ApplicationViewComponent
    param :course, Types::Instance(Course)
    option :lessons, Types::Array.of(Types::Instance(Lesson))

    delegate :instructor, to: :course

    # Stubbed until real progress tracking is implemented
    def progress_percent
      0
    end
  end
end
