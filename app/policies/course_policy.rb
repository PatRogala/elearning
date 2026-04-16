# policy for all users and guests to view courses
class CoursePolicy < ApplicationPolicy
  def index?
    true
  end

  def show?
    true
  end

  def enrolled?
    user.present?
  end

  # We can show all courses to all users and guests
  class Scope < ApplicationPolicy::Scope
    def resolve
      scope.published.recent
           .with_attached_image
           .with_rich_text_description
           .includes(instructor: { avatar_attachment: :blob })
    end
  end
end
