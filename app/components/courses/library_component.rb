module Courses
  # Component for rendering the library of courses
  class LibraryComponent < ApplicationViewComponent
    def courses
      @courses ||= Course.published.recent
                         .with_attached_image
                         .with_rich_text_description
                         .includes(:instructor).limit(3)
    end

    def render?
      courses.any?
    end
  end
end
