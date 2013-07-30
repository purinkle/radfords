Feature: Delete product
  In order to keep my inventory up-to-date
  As an administrator
  I need to delete out-of-date products

  Scenario: Try to delete a product that doesn't exist
    Given I am signed in
    And no products exist
    When I go to the delete product page
    Then I see the index products page
    And I see an invalid product message

  Scenario: Click the "Delete Product" button
    Given I am signed in
    And a product exists
    And I am on the delete product page
    When I click the "Delete Product" button
    Then I see the index products page
    And I see a product was deleted message
    And I don't see the product
