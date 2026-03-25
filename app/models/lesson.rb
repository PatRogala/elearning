# Unique lesson in a course
class Lesson < ApplicationRecord
  extend FriendlyId

  db_belongs_to :course

  validates :title, presence: true
  validates :position, presence: true, numericality: { only_integer: true, greater_than: 0 },
                       db_uniqueness: { scope: :course_id }
  validates :slug, presence: true, db_uniqueness: true
  friendly_id :title, use: :slugged
  has_rich_text :content

  private

  def should_generate_new_friendly_id?
    title_changed? || slug.blank?
  end
end
