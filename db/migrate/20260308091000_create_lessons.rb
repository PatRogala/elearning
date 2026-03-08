# We need lessons in a course
class CreateLessons < ActiveRecord::Migration[8.1]
  def change
    create_table :lessons do |t|
      t.string :title, null: false
      t.string :slug, null: false
      t.integer :position, null: false
      t.references :course, null: false, foreign_key: true
      t.timestamps
    end

    add_index :lessons, %i[course_id position], unique: true
  end
end
