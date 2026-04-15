module Teach
  # Form for creating and updating lessons in instructor dashboard
  class LessonForm < ApplicationForm
    model :lesson

    property :title
    property :content

    validates :title, presence: true
  end
end
