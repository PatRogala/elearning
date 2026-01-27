Feature: User login
  User wants to log in to their account. This is the basic flow of the application.

  Scenario: Successful login
    Given a user exists with email "patryk@example.com" and password "secret"
    When I log in as "patryk@example.com" with password "secret"
    Then I should see "Signed in successfully"

  Scenario: Unsuccessful login
    Given a user exists with email "patryk@example.com" and password "secret"
    When I log in as "patryk@example.com" with password "wrong"
    Then I should see "Invalid email or password."

  Scenario: Not registered user
    When I log in as "patryk@example.com" with password "secret"
    Then I should see "Invalid email or password."
