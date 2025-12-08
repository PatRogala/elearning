module Teach
  # Form for creating and updating courses in instructor dashboard
  class CourseForm < ApplicationForm
    property :title

    validates :title, presence: true
  end
end
