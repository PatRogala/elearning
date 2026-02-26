# Presentation of the course you can sign up for
class Course < ApplicationRecord
  extend FriendlyId

  scope :published, -> { where(published: true) }
  scope :recent, -> { order(created_at: :desc) }

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
    attachable.variant :cover, resize_to_limit: [1280, 720], format: :webp
    attachable.variant :thumb, resize_to_limit: [400, 225], format: :webp
  end
  monetize :price_cents, allow_nil: true, numericality: { greater_than_or_equal_to: 0 }

  friendly_id :title, use: :slugged

  def image_cover
    return image.variant(:cover) if image.attached?

    placeholder_image
  end

  private

  def placeholder_image
    "courses/course_placeholder.png"
  end

  def should_generate_new_friendly_id?
    title_changed? || slug.blank?
  end
end
