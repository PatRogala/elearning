# Presentation of the course you can sign up for
class Course < ApplicationRecord
  ACCEPTED_IMAGE_CONTENT_TYPES = %w[image/jpeg image/png].freeze

  scope :published, -> { where(published: true) }

  belongs_to :instructor, class_name: "User"

  validates :title, presence: true
  validates :title, uniqueness: { scope: :instructor_id }
  validates :image, content_type: ACCEPTED_IMAGE_CONTENT_TYPES
  validates :image, size: { less_than_or_equal_to: 5.megabytes }
  validates :price_cents, presence: true
  validates :price_currency, presence: true
  validates :published, inclusion: { in: [true, false] }, allow_nil: true

  has_rich_text :description
  has_one_attached :image do |attachable|
    attachable.variant :cover, resize_to_limit: [1280, 720]
    attachable.variant :thumb, resize_to_limit: [400, 225]
  end
  monetize :price_cents, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }

  def image_cover
    return image.variant(:cover) if image.attached?

    placeholder_image
  end

  private

  def placeholder_image
    "courses/placeholder_pattern.png"
  end
end
