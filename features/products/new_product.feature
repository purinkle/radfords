Feature: New product
  Scenario: Create a valid product
    Given I am signed in
    When I create a product with valid data
    Then I am redirected to the list of products
    And I see a successful product creation message
