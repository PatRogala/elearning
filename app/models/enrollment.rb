# Represents a user's enrollment in a course
class Enrollment < ApplicationRecord
  db_belongs_to :user
  db_belongs_to :course

  validates :user_id, db_uniqueness: { scope: :course_id }
end
