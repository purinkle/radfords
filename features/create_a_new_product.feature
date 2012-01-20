Feature: Create a new product
  In order to display new products
  As an administrator
  I want to add new products

  Scenario: Display the new products link
    Given I am logged in
    When I visit the Products page
    Then there is a link to create a new product
