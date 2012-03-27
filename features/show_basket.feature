Feature: Show basket
  In order to review what I am buying
  As a customer
  I need to see the contents of my basket

  Scenario: Display a basket's items
    Given I am a customer
    And some products have been created
    And I visit the products page
    When I click an "Add to Cart" button
    Then the product is listed
