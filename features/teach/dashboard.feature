Feature: Teacher Dashboard Access
  As a teacher
  I want to access the teacher dashboard
  So that I can manage my courses

  Scenario: Authorized Access
    Given a teacher exists with email "teacher@example.com" and password "secret"
    When I log in as "teacher@example.com" with password "secret"
    And I visit "the teacher dashboard page"
    Then I should be on "the teacher dashboard page"
    And I should see "Your Courses"

  Scenario: Unauthorized Access (Student)
    Given a user exists with email "student@example.com" and password "secret"
    When I log in as "student@example.com" with password "secret"
    And I visit "the teacher dashboard page"
    Then I should be on "the root page"
    And I should see "You are not authorized to perform this action."

  Scenario: Unauthenticated Access
    When I visit "the teacher dashboard page"
    Then I should be on "the login page"
    And I should see "You need to sign in or sign up before continuing."
