module Teach
  # Form for creating and updating courses in instructor dashboard
  class CourseForm < ApplicationForm
    model :course

    property :title
    property :description
    property :image, virtual: true

    validates :title, presence: true

    def image=(file)
      return if file.blank?

      model.image.attach(file)
    end
  end
end
