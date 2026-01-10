# Allow users to only update themselves.
class UserPolicy < ApplicationPolicy
  def update?
    user == record
  end

  class Scope < ApplicationPolicy::Scope
    # NOTE: Be explicit about which records you allow access to!
    # def resolve
    #   scope.all
    # end
  end
end
