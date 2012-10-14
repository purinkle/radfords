Feature: Edit product
  Scenario: Not logged in
    Given I am not signed in
    When I edit a product
    Then I see the sign in page
    And I see a sign in message
