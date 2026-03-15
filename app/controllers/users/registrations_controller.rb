module Users
  # We use custom registrations controller to send welcome email after user registration.
  class RegistrationsController < Devise::RegistrationsController
    def create
      super
      UserMailer.welcome_email(resource.id).deliver_later if resource.persisted?
    end
  end
end
