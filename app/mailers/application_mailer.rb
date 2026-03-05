# Base mailer for the application
class ApplicationMailer < ActionMailer::Base
  default from: "noreply@szkoleo.patrykrogala.dev"
  layout "mailer"
end
