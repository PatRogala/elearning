module Instructor
  # Policy that check if user is teacher and allow to access and manage courses
  class CoursePolicy < ApplicationPolicy
    def index?
      teacher?
    end

    def new?
      teacher?
    end

    def create?
      teacher?
    end

    def edit?
      teacher? && record.instructor == user
    end

    def update?
      teacher? && record.instructor == user
    end

    # Instructor can only see their own courses
    class Scope < ApplicationPolicy::Scope
      def resolve
        scope.where(instructor: user)
      end
    end
  end
end
