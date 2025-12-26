module Courses
  # Featured course on home page
  class FeaturedComponent < ApplicationViewComponent
    attr_reader :course

    def render?
      course.present?
    end

    def before_render
      @course = Course.published.first
    end
  end
end
