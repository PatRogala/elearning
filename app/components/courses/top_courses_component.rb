module Courses
  # Show top courses on landing page top section
  class TopCoursesComponent < ApplicationViewComponent
    def courses
      @courses ||= Course.published.recent.limit(6).with_attached_image.includes(:instructor)
    end

    def render?
      courses.any?
    end
  end
end
