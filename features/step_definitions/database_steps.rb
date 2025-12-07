Given("a user exists with email {string} and password {string}") do |email, password|
  FactoryBot.create(:user, email: email, password: password, password_confirmation: password)
end

Given("a teacher exists with email {string} and password {string}") do |email, password|
  user = FactoryBot.create(:user, email: email, password: password, password_confirmation: password)
  role = Role.teacher
  UserRole.create(user: user, role: role)
end
