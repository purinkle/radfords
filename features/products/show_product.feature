Feature: Show product
  Scenario: Not signed in
    Given I am not signed in
    When I go to the show product page
    Then I see the sign in page
    And I see a sign in message
