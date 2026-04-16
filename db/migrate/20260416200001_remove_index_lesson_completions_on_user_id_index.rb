# Duplicated index
class RemoveIndexLessonCompletionsOnUserIdIndex < ActiveRecord::Migration[8.1]
  def up
    safety_assured do
      remove_index "lesson_completions", name: "index_lesson_completions_on_user_id"
    end
  end
end
