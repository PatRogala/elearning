# Allow us to avoid using raw paths in feature files
# and to make it more readable for non-technical people
module NavigationHelpers
  def path_to(page_name)
    case page_name
    when "the teacher dashboard page"
      teach_dashboard_path(locale: :en)
    when "the new course page"
      new_teach_course_path(locale: :en)
    when "the root page"
      root_path(locale: :en)
    when "the login page"
      new_user_session_path(locale: :en)
    else
      raise "Can't find mapping from \"#{page_name}\" to a path."
    end
  end
end

World(NavigationHelpers)

When("I visit {string}") do |page_name|
  visit path_to(page_name)
end

Then("I should be on {string}") do |page_name|
  expect(page).to have_current_path(path_to(page_name), ignore_query: true)
end
