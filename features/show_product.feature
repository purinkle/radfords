Feature: Show product
  In order to check product details
  As an administrator
  I need to see individual products

  Scenario: Display the product's details
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I create a valid product
    Then the product's title is displayed
    And the product's description is displayed
    And an image of the product is displayed
    And the product's price is displayed

  Scenario: Display an "Edit" link
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I create a valid product
    Then there is an "Edit" link
