Feature: Sessions
  Scenario: Create invalid session
    When I create a session with invalid data
    Then I see the "Sign In" page
    And I see an "Invalid email or password" alert
