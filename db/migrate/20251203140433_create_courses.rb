# Course representation in datbase
class CreateCourses < ActiveRecord::Migration[8.1]
  def change
    create_table :courses do |t|
      t.string :title
      t.references :instructor, null: false, foreign_key: { to_table: :users }
      t.timestamps
    end

    add_index :courses, %i[instructor_id title], unique: true
  end
end
