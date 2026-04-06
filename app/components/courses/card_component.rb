module Courses
  # Component for rendering a course card
  class CardComponent < ApplicationViewComponent
    param :course, Types::Instance(Course)

    delegate :title, to: :course
    delegate :short_description, to: :course
    delegate :instructor, to: :course
    delegate :image_cover, to: :course
  end
end
