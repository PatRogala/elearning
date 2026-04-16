# Some useful presenter methods for Lesson model
class LessonPresenter < ApplicationPresenter
  WORDS_PER_MINUTE = 200.0
  MINUTES_TO_COMPLETE_EXTRA = 10 # Extra minutes to complete the lesson (homework, etc.)

  presents :lesson

  def formatted_time_to_complete
    return "00:00" if lesson.content.body.blank?

    Rails.cache.fetch("lesson_#{lesson.id}_#{lesson.updated_at.to_i}_time_to_complete") do
      t = time_to_complete_in_minutes

      minutes = t.floor
      seconds = ((t - minutes) * 60).round.to_s.rjust(2, "0")
      "#{minutes}:#{seconds}"
    end
  end

  def time_to_complete_in_minutes
    (lesson.content.body.to_plain_text.scan(/\w+/).count / WORDS_PER_MINUTE).round(2) + MINUTES_TO_COMPLETE_EXTRA
  end
end
