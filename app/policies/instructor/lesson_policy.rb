module Instructor
  # Policy that checks if user is teacher and allows managing lessons
  class LessonPolicy < ApplicationPolicy
    def new?
      teacher? && record.course.instructor == user
    end

    def create?
      teacher? && record.course.instructor == user
    end

    def edit?
      teacher? && record.course.instructor == user
    end

    def update?
      teacher? && record.course.instructor == user
    end

    def destroy?
      teacher? && record.course.instructor == user
    end
  end
end
