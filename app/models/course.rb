# Presentation of the course you can sign up for
class Course < ApplicationRecord
  belongs_to :instructor, class_name: "User"

  validates :title, presence: true
  validates :title, uniqueness: { scope: :instructor_id }

  has_rich_text :description
end
