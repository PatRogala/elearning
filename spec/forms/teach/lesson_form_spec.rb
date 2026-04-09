require "rails_helper"

RSpec.describe Teach::LessonForm do
  let(:course) { create(:course) }
  let(:lesson) { build(:lesson, course: course) }
  let(:form) { described_class.new(lesson) }

  describe "validations" do
    it "validates presence of title" do
      form.title = nil
      expect(form).not_to be_valid
    end

    it "is valid with a title" do
      form.title = "Introduction"
      expect(form).to be_valid
    end
  end
end
