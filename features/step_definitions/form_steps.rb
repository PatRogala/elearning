When("I fill in {string} with {string}") do |field, value|
  fill_in field, with: value
end

When("I click {string}") do |link_or_button|
  click_on link_or_button
end
