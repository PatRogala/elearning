module Courses
  # Component for displaying the store page for a course
  class StorePageComponent < ApplicationViewComponent
    param :course, Types::Instance(Course)

    delegate :instructor, to: :course
  end
end
