module Teach
  # Controller for teaching courses
  class CoursesController < ApplicationController
    before_action :authenticate_user!

    def new
      @course = Course.new
      authorize([:instructor, @course])
    end

    def create
      # TODO: Implement
    end
  end
end
