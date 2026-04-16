module Courses
  # Full-page catalog of courses the current user is enrolled in
  class EnrolledCatalogComponent < ApplicationViewComponent
    param :courses, Types::Array.of(Types::Instance(Course))
  end
end
