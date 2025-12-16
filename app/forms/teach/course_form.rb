module Teach
  # Form for creating and updating courses in instructor dashboard
  class CourseForm < ApplicationForm
    model :course

    property :title
    property :description
    property :image, virtual: true

    validates :title, presence: true

    def image=(file)
      if file.present?
        model.image.attach(file)
      elsif file == ""
        model.image.purge_later
      end
    end
  end
end
