# Allows users to view courses
class CoursesController < ApplicationController
  def index
    @courses = policy_scope(Course)
    authorize(@courses)
  end

  def show
    @course = policy_scope(Course).friendly.find(params[:id])
    authorize(@course)
  end
end
