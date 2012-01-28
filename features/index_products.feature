Feature: Index products
  In order to maintain products
  As an administrator
  I need to see all the products

  Scenario: Display each product's details
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    When I click the "Back" link
    Then the product's title is displayed
    And the product's description is displayed
    And the product's image is displayed
