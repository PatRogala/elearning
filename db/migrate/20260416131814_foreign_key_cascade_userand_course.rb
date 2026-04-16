# No callbacks we can use cascade deletion for enrollments
class ForeignKeyCascadeUserandCourse < ActiveRecord::Migration[8.1]
  def change
    safety_assured do
      # Remove existing foreign keys to re-add with cascade (if present)
      remove_foreign_key :enrollments, :users if foreign_key_exists?(:enrollments, :users)
      remove_foreign_key :enrollments, :courses if foreign_key_exists?(:enrollments, :courses)

      add_foreign_key :enrollments, :users, on_delete: :cascade
      add_foreign_key :enrollments, :courses, on_delete: :cascade
    end
  end
end
