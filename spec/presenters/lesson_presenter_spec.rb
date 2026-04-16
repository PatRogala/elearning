require "rails_helper"

RSpec.describe LessonPresenter, type: :presenter do
  subject(:presenter) { present(lesson) }

  let(:lesson) { create(:lesson) }

  describe "#formatted_time_to_complete" do
    before { Rails.cache.clear }

    context "when lesson has no content" do
      before do
        lesson.content.body = nil
      end

      it "returns zero minutes and seconds" do
        expect(presenter.formatted_time_to_complete).to eq("00:00")
      end
    end

    context "when lesson has content" do
      before do
        lesson.content.body = "word " * 200
        lesson.save!
      end

      it "returns formatted time as MM:SS" do
        result = presenter.formatted_time_to_complete

        expect(result).to match(/\A\d+:\d{2}\z/)
      end

      it "includes the extra 10 minutes" do
        # 200 words / 200 wpm = 1.0 minute + 10 extra = 11:00
        expect(presenter.formatted_time_to_complete).to eq("11:00")
      end

      it "zero-pads seconds to two digits" do
        # 100 words / 200 wpm = 0.5 min + 10 = 10.5 min → "10:30"
        lesson.content.body = "word " * 100
        lesson.save!

        expect(presenter.formatted_time_to_complete).to eq("10:30")
      end
    end

    context "with caching" do
      before do
        lesson.content.body = "word " * 200
        lesson.save!
      end

      it "caches the result" do
        allow(Rails.cache).to receive(:fetch).and_call_original

        presenter.formatted_time_to_complete

        expect(Rails.cache).to have_received(:fetch).once
      end

      it "uses a cache key that includes lesson id and updated_at" do
        expected_key = "lesson_#{lesson.id}_#{lesson.updated_at.to_i}_time_to_complete"
        allow(Rails.cache).to receive(:fetch).and_call_original

        presenter.formatted_time_to_complete

        expect(Rails.cache).to have_received(:fetch).with(expected_key).once
      end

      it "busts the cache when lesson is updated" do
        first_result = presenter.formatted_time_to_complete

        lesson.content.body = "word " * 400
        lesson.save!

        new_presenter = present(lesson.reload)
        expect(new_presenter.formatted_time_to_complete).not_to eq(first_result)
      end
    end
  end
end
