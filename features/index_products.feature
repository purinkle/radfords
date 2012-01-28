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
    And the product's price is displayed
    And there is an "Edit" link

  Scenario: Display the "Edit Product" page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Back" link
    When I click an "Edit" link
    Then the "Edit Product" page is displayed
