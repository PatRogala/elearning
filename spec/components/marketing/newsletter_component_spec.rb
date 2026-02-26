require "rails_helper"

RSpec.describe Marketing::NewsletterComponent, type: :component do
  it "renders the newsletter section" do
    render_inline(described_class.new)
    expect(page).to have_content("Don't miss the next premiere")
      .and have_content("No spam. We only send notifications about new materials and discounts.")
      .and have_content("Sign up")
  end
end
