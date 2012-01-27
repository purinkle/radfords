Feature: Create product
  In order to display new products
  As an administrator
  I want to be able to create new products

  Scenario: Display a "New Product" link
    Given I am logged in
    When I click the "Products" link
    Then there is a "New Product" link

  Scenario: Display the "New Product" page
    Given I am logged in
    And I click the "Products" link
    When I click the "New Product" link
    Then the "New Product" page is displayed

  Scenario: Redirect to a product page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I create a valid product
    Then I am shown a product page
