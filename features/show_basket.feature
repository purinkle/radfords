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
    And an "Empty basket" button is displayed

  Scenario: Redirect to the Products page
    Given I am a customer
    When I visit an invalid basket
    Then I am redirected to the Products page
    And an "Invalid basket" message is displayed

  Scenario: Display total item price
    Given I am a customer
    And some products have been created
    And I visit the products page
    When I add some products to my basket
    Then the total price for each product is displayed
    And the basket's total price is displayed
