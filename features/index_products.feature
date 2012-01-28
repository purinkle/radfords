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
    And there is a "Show" link
    And there is an "Edit" link
    And there is a "Delete" button

  Scenario: Display the "Edit Product" page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Back" link
    When I click an "Edit" link
    Then the "Edit Product" page is displayed

  Scenario: Display the product's page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Back" link
    When I click a "Show" link
    Then the product's page is displayed

  Scenario: Delete the product
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Back" link
    When I delete a product
    Then I am redirected back to the "Products" page
    And the product is no longer displayed
