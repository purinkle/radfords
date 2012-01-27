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
    And there is an "Edit" link
    And there is a "Back" link

  Scenario: Display the "Edit" page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    When I click the "Edit" link
    Then the "Edit Product" page is displayed

  Scenario: Display the "Products" page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    When I click the "Back" link
    Then the "Products" page is displayed
