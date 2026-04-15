module Courses
  # Featured course on home page
  class FeaturedComponent < ApplicationViewComponent
    attr_reader :course

    def render?
      course.present?
    end

    def before_render
      @course = Course.published.recent.first
    end

    def title
      course.title.split[0]
    end

    def subtitle
      course.title.split[1..].join(" ")
    end
  end
end
