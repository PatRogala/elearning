require "rails_helper"

RSpec.describe "Courses", type: :request do
  describe "GET /index" do
    before { get courses_path }

    it "returns http success for any user/guest" do
      expect(response).to have_http_status(:success)
    end
  end
end
