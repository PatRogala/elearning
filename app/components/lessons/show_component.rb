module Lessons
  # Lesson viewer for enrolled users with sticky sidebar navigation
  class ShowComponent < ApplicationViewComponent
    param :lesson, Types::Instance(Lesson)
    option :course, Types::Instance(Course)
    option :course_lessons, Types::Array.of(Types::Instance(Lesson))

    def lesson_index
      course_lessons.index(lesson).to_i
    end

    def lesson_number
      lesson_index + 1
    end

    def prev_lesson
      course_lessons[lesson_index - 1] if lesson_index.positive?
    end

    def next_lesson
      course_lessons[lesson_index + 1]
    end
  end
end
