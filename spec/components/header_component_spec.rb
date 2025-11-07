require "rails_helper"

RSpec.describe HeaderComponent, type: :component do
  context "when user is signed in" do
    let(:current_user) { build(:user) }

    it "renders dashboard link" do
      render_inline(described_class.new(current_user: current_user))
      expect(page).to have_link("Dashboard", href: "#")
    end

    it "renders courses link" do
      render_inline(described_class.new(current_user: current_user))
      expect(page).to have_link("Courses", href: "#")
    end

    it "renders profile link" do
      render_inline(described_class.new(current_user: current_user))
      expect(page).to have_link("Profile", href: "#")
    end

    it "renders sign out link" do
      render_inline(described_class.new(current_user: current_user))
      expect(page).to have_button("Sign out")
    end
  end

  context "when user is not signed in" do
    let(:current_user) { nil }

    it "renders sign in link" do
      render_inline(described_class.new(current_user: current_user))
      expect(page).to have_link("Log in", href: "/en/users/sign_in")
    end

    it "renders sign up link" do
      render_inline(described_class.new(current_user: current_user))
      expect(page).to have_link("Sign up", href: "/en/users/sign_up")
    end
  end
end
