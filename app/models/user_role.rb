# Join model for users and roles
class UserRole < ApplicationRecord
  db_belongs_to :user
  db_belongs_to :role

  validates :user_id, db_uniqueness: { scope: :role_id }
end
