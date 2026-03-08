require "rails_helper"

RSpec.describe Lesson, type: :model do
  it_behaves_like "a valid factory"
  it_behaves_like "a model with belongs_to association", :course
  it_behaves_like "a model with uniqueness scope validation", :lesson, :position, :course_id
  it_behaves_like "a model with presence validation", :title
  it_behaves_like "a model with presence validation", :position
end
