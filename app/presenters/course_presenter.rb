# Some useful helpers for course presentation
class CoursePresenter < ApplicationPresenter
  presents :course

  def formatted_total_time_to_complete
    t = total_time_to_complete
    hours = t.floor / 60
    minutes = t.floor % 60
    "#{hours}h #{minutes}m"
  end

  def total_time_to_complete
    return 0 if course.lessons.empty?

    course.lessons.sum do |lesson|
      k(lesson).time_to_complete_in_minutes
    end
  end
end
