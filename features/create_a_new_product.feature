Feature: Create a new product
  In order to display new products
  As an administrator
  I want to add new products

  Scenario: Display the new products link
    Given I am logged in
    When I visit the Products page
    Then there is a link to create a new product

  Scenario: Display the new product form
    Given I am logged in
    And I visit the Products page
    When I click the new product link
    Then I am shown the new product page

  Scenario: Create a new product
    Given I am logged in
    And I visit the New Product page
    When I submit valid data
    Then I am shown a Product page
