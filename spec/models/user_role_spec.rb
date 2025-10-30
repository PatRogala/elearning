require "rails_helper"

RSpec.describe UserRole, type: :model do
  it_behaves_like "a valid factory"
  it_behaves_like "a model with belongs_to association", :user
  it_behaves_like "a model with belongs_to association", :role
  it_behaves_like "a model with uniqueness scope validation", :user_role, :user_id, :role_id
end
