Feature: Delete product
  In order to keep my inventory up-to-date
  As an administrator
  I need to delete out-of-date products

  Scenario: Visit the page without signing in
    Given I am not signed in
    When I go to the delete product page
    Then I see the sign in page
    And I see a sign in message
