# Courses should only be visible after publication
class AddPublishedFlagToCourses < ActiveRecord::Migration[8.1]
  def change
    add_column :courses, :published, :boolean, default: false, null: false
  end
end
