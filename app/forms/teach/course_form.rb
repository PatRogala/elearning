module Teach
  # Form for creating and updating courses in instructor dashboard
  class CourseForm < ApplicationForm
    model :course

    property :title
    property :description

    validates :title, presence: true
  end
end
