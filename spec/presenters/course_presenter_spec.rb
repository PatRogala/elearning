require "rails_helper"

RSpec.describe CoursePresenter, type: :presenter do
  subject(:presenter) { present(course) }

  let(:course) { create(:course) }

  describe "#total_time_to_complete" do
    context "when course has no lessons" do
      it "returns 0" do
        expect(presenter.total_time_to_complete).to eq(0)
      end
    end

    context "when course has lessons" do
      before do
        Prosopite.pause
        create_list(:lesson, 3, course: course)
        Prosopite.resume
        allow_any_instance_of(LessonPresenter).to receive(:time_to_complete_in_minutes).and_return(20) # rubocop:disable RSpec/AnyInstance
      end

      it "sums time_to_complete_in_minutes across all lessons" do
        expect(presenter.total_time_to_complete).to eq(60)
      end
    end
  end

  describe "#formatted_total_time_to_complete" do
    before do
      allow(presenter).to receive(:total_time_to_complete).and_return(total_minutes) # rubocop:disable RSpec/SubjectStub
    end

    context "when total is 0 minutes" do
      let(:total_minutes) { 0 }

      it "returns 0h 0m" do
        expect(presenter.formatted_total_time_to_complete).to eq("0h 0m")
      end
    end

    context "when total is less than 60 minutes" do
      let(:total_minutes) { 45 }

      it "returns 0h Ym" do
        expect(presenter.formatted_total_time_to_complete).to eq("0h 45m")
      end
    end

    context "when total is exactly 60 minutes" do
      let(:total_minutes) { 60 }

      it "returns 1h 0m" do
        expect(presenter.formatted_total_time_to_complete).to eq("1h 0m")
      end
    end

    context "when total is more than 60 minutes" do
      let(:total_minutes) { 75 }

      it "returns correct hours and remaining minutes" do
        expect(presenter.formatted_total_time_to_complete).to eq("1h 15m")
      end
    end

    context "when total is multiple hours" do
      let(:total_minutes) { 150 }

      it "returns correct hours and minutes" do
        expect(presenter.formatted_total_time_to_complete).to eq("2h 30m")
      end
    end
  end
end
