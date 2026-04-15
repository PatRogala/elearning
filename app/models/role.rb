# Application Roles for user authorization
class Role < ApplicationRecord
  ADMIN_ID = 1
  TEACHER_ID = 2
  DEVELOPER_ID = 3

  has_many :user_roles, dependent: :delete_all
  has_many :users, through: :user_roles

  validates :name, presence: true, db_uniqueness: { index_name: :index_roles_lower_name_, case_sensitive: false }

  def self.admin
    find(ADMIN_ID)
  end

  def self.teacher
    find(TEACHER_ID)
  end

  def self.developer
    find(DEVELOPER_ID)
  end
end
