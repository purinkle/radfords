Feature: Show basket
  In order to review what I am buying
  As a customer
  I need to see the contents of my basket

  Scenario: Display total item price
    Given I am a customer
    And some products have been created
    And I visit the products page
    And I add some products to my basket
    When I click the "Basket" link
    Then the products are listed
    And the total price for each product is displayed
    And the basket's total price is displayed
    And an "Empty basket" button is displayed

  Scenario: Redirect to the Products page
    Given I am a customer
    When I visit an invalid basket
    Then I am redirected to the Products page
    And an "Invalid basket" message is displayed
