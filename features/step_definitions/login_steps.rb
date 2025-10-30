When("I log in as {string} with password {string}") do |email, password|
  visit new_user_session_path
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  click_button "Log in"
end
