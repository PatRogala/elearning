module Courses
  # Component for displaying the store page for a course
  class StorePageComponent < ApplicationViewComponent
    param :course, Types::Instance(Course)
    option :enrolled, Types::Bool, default: proc { false }

    delegate :instructor, to: :course
  end
end
