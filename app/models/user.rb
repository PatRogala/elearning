# Base Devise user model for the application
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  has_many :user_roles, dependent: :delete_all
  has_many :roles, through: :user_roles
  has_many :created_courses, class_name: "Course", foreign_key: "instructor_id", dependent: :destroy,
                             inverse_of: :instructor

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :encrypted_password, presence: true
  validates :sign_in_count, presence: true

  normalizes :first_name, with: ->(name) { name.capitalize }
  normalizes :last_name, with: ->(name) { name.capitalize }

  def admin?
    roles.include?(Role.admin)
  end

  def teacher?
    roles.include?(Role.teacher)
  end

  def full_name
    "#{first_name} #{last_name}"
  end
end
