# Tracks when a user has completed a lesson
class LessonCompletion < ApplicationRecord
  db_belongs_to :user
  db_belongs_to :lesson
  validates :user_id, db_uniqueness: { scope: :lesson_id }
end
