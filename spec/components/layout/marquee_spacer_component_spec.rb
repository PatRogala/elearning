require "rails_helper"

RSpec.describe Layout::MarqueeSpacerComponent, type: :component do
  it "renders marquee spacer with items" do
    render_inline(described_class.new)

    expect(page).to have_text("interactive lessons")
      .and have_text("learn at your own pace")
      .and have_text("free courses")
  end
end
