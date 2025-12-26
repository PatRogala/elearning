require "rails_helper"

RSpec.describe Courses::FeaturedComponent, type: :component do
  subject(:component) { described_class.new }

  it "does not render if there is no published course" do
    render_inline(component)
    expect(component).not_to be_render
  end

  it "renders featured course" do
    create(:course, :published)
    render_inline(component)
    expect(component).to be_render
  end
end
