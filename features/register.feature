Feature: User registration
  User wants to register a new account. This is the basic flow of the application.

  Scenario: Successful registration
    When I register as "patryk@example.com" with password "secret"
    Then I should see "Welcome! You have signed up successfully."

  Scenario: User already registered
    Given a user exists with email "patryk@example.com" and password "secret"
    When I register as "patryk@example.com" with password "secret"
    Then I should see "Email has already been taken"
