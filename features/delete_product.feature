Feature: Delete product
  In order to keep my inventory up-to-date
  As an administrator
  I need to delete out-of-date products

  Scenario: Visit the page without signing in
    Given I am not signed in
    When I go to the delete product page
    Then I see the sign in page
    And I see a sign in message

  Scenario: Try to delete a product that doesn't exist
    Given I am signed in
    And no products exist
    When I go to the delete product page
    Then I see the index products page
    And I see an invalid product message
