When("I register as {string} with password {string} and name {string} {string}") do |email, password, fn, ln|
  visit new_user_registration_path
  fill_in "user_email", with: email
  fill_in "user_password", with: password
  fill_in "user_password_confirmation", with: password
  fill_in "user_first_name", with: fn
  fill_in "user_last_name", with: ln
  click_button "Sign up"
end
