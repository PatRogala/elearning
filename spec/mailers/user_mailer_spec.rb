require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome_email" do
    let(:user) { create(:user) }
    let(:mail) { described_class.welcome_email(user) }

    it "renders the subject" do
      expect(mail.subject).to eq("Welcome to Szkoleo")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["noreply@szkoleo.patrykrogala.dev"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include(user.email)
        .and include("Welcome to Szkoleo!")
        .and include("Thank you for registering in our platform.")
        .and include("Login")
    end
  end
end
