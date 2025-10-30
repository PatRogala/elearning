# Application Roles for user authorization
class Role < ApplicationRecord
  ADMIN_ID = 1
  TEACHER_ID = 2

  validates :name, presence: true, uniqueness: true

  def self.admin
    find(ADMIN_ID)
  end

  def self.teacher
    find(TEACHER_ID)
  end
end
