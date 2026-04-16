module Courses
  # Show enrolled courses for the current user on the dashboard
  class MyCoursesComponent < ApplicationViewComponent
    param :user, Types::Instance(User)

    def courses
      @courses ||= user.enrolled_courses
                       .published
                       .with_attached_image
                       .includes(instructor: { avatar_attachment: :blob })
    end

    def render?
      courses.any?
    end
  end
end
