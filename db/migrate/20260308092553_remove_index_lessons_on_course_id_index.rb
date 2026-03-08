# Duplicated index index_lessons_on_course_id_and_position covers it
class RemoveIndexLessonsOnCourseIdIndex < ActiveRecord::Migration[8.1]
  def down
    remove_index "lessons", name: "index_lessons_on_course_id"
  end
end
