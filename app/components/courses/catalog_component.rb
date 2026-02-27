module Courses
  # Component for rendering the catalog of courses
  class CatalogComponent < ApplicationViewComponent
    param :courses, Types::Array.of(Types::Instance(Course))

    delegate :turbo_frame_tag, to: :helpers
  end
end
