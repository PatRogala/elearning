module Instructor
  # Dashboard for instructors to manage their courses
  class DashboardComponent < ApplicationViewComponent
    option :user, Types::Instance(User).optional

    def render?
      user&.teacher?
    end

    def created_courses_count
      user.created_courses.count
    end

    def active_students_count
      k(:instructor, user).enrolled_users_count
    end

    def total_revenue
      0 # TODO: Get total revenue
    end

    def courses
      user.created_courses
    end
  end
end
