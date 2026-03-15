require "rails_helper"

RSpec.describe UserMailer, type: :mailer do
  describe "welcome_email" do
    let(:user) { create(:user) }
    let(:mail) { described_class.welcome_email(user.id) }

    it "renders the subject" do
      expect(mail.subject).to eq("Welcome to Szkoleo")
    end

    it "renders the receiver email" do
      expect(mail.to).to eq([user.email])
    end

    it "renders the sender email" do
      expect(mail.from).to eq(["patryk@szkoleo.patrykrogala.dev"])
    end

    it "renders the body" do
      expect(mail.body.encoded).to include(user.first_name)
        .and include("Welcome on")
        .and include("Your account has been successfully created. No spam - just pure knowledge and specific skills.")
        .and include("Browse Catalog")
        .and include("Click the button above to see the courses.")
        .and include("Your Profile")
        .and include("Don&#39;t want to receive these messages?")
        .and include("Unsubscribe")
    end
  end
end
