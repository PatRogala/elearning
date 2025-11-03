# Policy for the dashboard
class DashboardPolicy < ApplicationPolicy
  def index?
    true
  end

  # Scope policy for the dashboard
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.all
    end
  end
end
