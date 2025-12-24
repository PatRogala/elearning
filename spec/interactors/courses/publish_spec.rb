require "rails_helper"

RSpec.describe Courses::Publish do
  subject(:context) { described_class.call(course: course) }

  let(:course) { build(:course) }

  describe "#call" do
    context "when course has valid attributes" do
      before do
        course.update(description: "Course description")
      end

      it "publishes course" do
        allow(course).to receive(:update!).with(published: true)
        context
        expect(course).to have_received(:update!).with(published: true)
      end
    end

    context "when course has invalid attributes" do
      it "does not publish course if description is not present" do
        course.description = nil
        context
        expect(context.message).to eq("Course description cannot be blank")
      end

      it "does not publish course if image is not present" do
        course.image = nil
        context
        expect(context.message).to eq("Cover image cannot be blank")
      end
    end
  end
end
