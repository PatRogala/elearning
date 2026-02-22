# Cascade delete for user created courses
class CascadeUserCreatedCourses < ActiveRecord::Migration[8.1]
  def change
    safety_assured do
      remove_foreign_key :courses, :users
      add_foreign_key :courses, :users, on_delete: :cascade, column: :instructor_id
    end
  end
end
