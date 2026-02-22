# Deuplicated index
class RemoveIndexCoursesOnInstructorIdIndex < ActiveRecord::Migration[8.1]
  def up
    remove_index "courses", name: "index_courses_on_instructor_id"
  end

  def down
    add_index "courses", "instructor_id"
  end
end
