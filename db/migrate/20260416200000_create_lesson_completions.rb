# Tracks which lessons a user has completed (marked by scrolling to bottom)
class CreateLessonCompletions < ActiveRecord::Migration[8.1]
  def change
    create_table :lesson_completions do |t|
      t.references :user, null: false, foreign_key: { on_delete: :cascade }
      t.references :lesson, null: false, foreign_key: { on_delete: :cascade }
      t.timestamps
    end

    add_index :lesson_completions, %i[user_id lesson_id], unique: true
  end
end
