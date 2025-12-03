class ChangeCoursesTitleNullConstraint < ActiveRecord::Migration[8.1]
  def change
    safety_assured do
      change_column_null :courses, :title, false
    end
  end
end
