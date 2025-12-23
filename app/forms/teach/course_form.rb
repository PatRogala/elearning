module Teach
  # Form for creating and updating courses in instructor dashboard
  class CourseForm < ApplicationForm
    model :course

    property :title
    property :description
    property :image, virtual: true
    property :price, virtual: true

    validates :title, presence: true

    def image=(file)
      return if file.blank?

      model.image.attach(file)
    end

    def price=(value)
      model.price_cents = value.to_d * 100
    end

    def price
      model.price.amount
    end
  end
end
