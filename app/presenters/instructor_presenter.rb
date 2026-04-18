# Some useful helpers for instructor presentation like user count
class InstructorPresenter < ApplicationPresenter
  presents :user

  def enrolled_users_count
    Enrollment.where(course: user.created_courses).count
  end
end
