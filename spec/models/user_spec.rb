require "rails_helper"

RSpec.describe User, type: :model do
  it_behaves_like "a valid factory"
  it_behaves_like "a model with presence validation", :email
  it_behaves_like "a model with uniqueness validation", :email
  it_behaves_like "a model with has_many association", :roles
  it_behaves_like "a model with has_many association", :user_roles
  it_behaves_like "a model with has_many association", :created_courses
end
