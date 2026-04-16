# Policy for enrolled users to view lessons
class LessonPolicy < ApplicationPolicy
  def show?
    user.present? && record.course.enrollments.exists?(user: user)
  end
end
