Given("a user exists with email {string} and password {string}") do |email, password|
  FactoryBot.create(:user, email: email, password: password, password_confirmation: password)
end
