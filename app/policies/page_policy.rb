# policy for all users and guests to view static pages
class PagePolicy < ApplicationPolicy
  def show?
    true
  end
end
