# Some useful helpers for course presentation
class CoursePresenter < ApplicationPresenter
  presents :course

  def formatted_total_time_to_complete
    t = total_time_to_complete
    hours = t.floor / 60
    minutes = t.floor % 60
    "#{hours}h #{minutes}m"
  end

  def completion_percentage_for_user(user)
    return 0 if course.lessons.empty?

    completed_lessons = user.lesson_completions.where(lesson: course.lessons).count
    (completed_lessons.to_f / course.lessons.count * 100).round
  end

  def total_time_to_complete
    return 0 if course.lessons.empty?

    course.lessons.sum do |lesson|
      k(lesson).time_to_complete_in_minutes
    end
  end
end
