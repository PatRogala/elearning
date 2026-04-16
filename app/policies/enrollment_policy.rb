# Policy for course enrollment actions
class EnrollmentPolicy < ApplicationPolicy
  def create?
    user.present?
  end
end
