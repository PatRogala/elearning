module Instructor
  # Policy that check if user is teacher and allow to access and manage courses
  class CoursePolicy < ApplicationPolicy
    def index?
      teacher?
    end

    class Scope < ApplicationPolicy::Scope
      # NOTE: Be explicit about which records you allow access to!
      # def resolve
      #   scope.all
      # end
    end
  end
end
