# Base Devise user model for the application
class User < ApplicationRecord
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :trackable

  has_many :user_roles, dependent: :delete_all
  has_many :roles, through: :user_roles
  has_many :created_courses, class_name: "Course", foreign_key: "instructor_id", dependent: :destroy,
                             inverse_of: :instructor
  has_one_attached :avatar do |attachable|
    attachable.variant :thumb, resize_to_limit: [128, 128]
    attachable.variant :preview, resize_to_limit: [1000, 1000]
  end

  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :email, presence: true, uniqueness: true
  validates :reset_password_token, uniqueness: true, allow_nil: true
  validates :encrypted_password, presence: true
  validates :sign_in_count, presence: true
  validates :bio, length: { maximum: 512 }, allow_nil: true

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

  def avatar_preview
    return avatar.variant(:preview) if avatar.attached?

    placeholder_image
  end

  private

  def placeholder_image
    "courses/placeholder_pattern.png"
  end
end
