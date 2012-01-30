Feature: Edit product
  In order to keep products up-to-date
  As an administrator
  I need to edit product details

  Scenario: Edit the product from the product's page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    When I click the "Edit" link
    Then the product's title is displayed
    And the product's description is displayed
