require "rails_helper"

RSpec.describe Course, type: :model do
  it_behaves_like "a valid factory"
  it_behaves_like "a model with belongs_to association", :instructor
  it_behaves_like "a model with uniqueness scope validation", :course, :title, :instructor_id
end
