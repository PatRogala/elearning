# Presentation of the course you can sign up for
class Course < ApplicationRecord
  ACCEPTED_IMAGE_CONTENT_TYPES = %w[image/jpeg image/png].freeze

  belongs_to :instructor, class_name: "User"

  validates :title, presence: true
  validates :title, uniqueness: { scope: :instructor_id }
  validates :image, content_type: ACCEPTED_IMAGE_CONTENT_TYPES
  validates :image, size: { less_than_or_equal_to: 5.megabytes }

  has_rich_text :description
  has_one_attached :image do |attachable|
    attachable.variant :cover, resize_to_limit: [1280, 720]
    attachable.variant :thumb, resize_to_limit: [400, 225]
  end

  def image_cover
    return image.variant(:cover) if image.attached?

    placeholder_image
  end

  def placeholder_image
    "courses/placeholder_pattern.png"
  end
end
