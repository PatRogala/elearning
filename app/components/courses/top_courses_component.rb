module Courses
  # Show top courses on landing page top section
  class TopCoursesComponent < ApplicationViewComponent
    def courses
      @courses ||= Course.published
                         .recent
                         .limit(6)
                         .with_attached_image
                         .with_rich_text_description
                         .includes(instructor: { avatar_attachment: :blob })
    end

    def render?
      courses.any?
    end
  end
end
