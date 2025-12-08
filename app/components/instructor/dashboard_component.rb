module Instructor
  # Dashboard for instructors to manage their courses
  class DashboardComponent < ApplicationViewComponent
    option :user, Types::Instance(User).optional

    def render?
      user&.teacher?
    end

    def created_courses_count
      12 # TODO: Get created courses count
    end

    def active_students_count
      1240 # TODO: Get active students count
    end

    def total_revenue
      8450 # TODO: Get total revenue
    end

    def courses
      user.created_courses
    end
  end
end
