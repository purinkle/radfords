Feature: New order
  In order to buy products
  As a customer
  I want to create orders

  Scenario: Display the order form
    Given I am a customer
    And some products have been created
    And I visit the products page
    And I add some products to my basket
    And I click the "Basket" link
    When I click the "Checkout" button
    Then there is a "Name" field
    And there is an "Address" field
    And there is an "Email" field
    And there is a "Place Order" button

  Scenario: Redirect empty baskets
    Given I am a customer
    And I visit the home page
    And I click the "Basket" link
    When I click the "Checkout" button
    Then I am shown the products page

  Scenario: Validate submitted fields
    Given I am a customer
    And some products have been created
    And I visit the products page
    And I add some products to my basket
    And I click the "Basket" link
    And I click the "Checkout" button
    When I create an invalid order
    Then I am shown the new order page
    And a "Name can't be blank" message is shown
    And an "Address can't be blank" message is shown
    And an "Email can't be blank" message is shown

  Scenario: Submit a valid order
    Given I am a customer
    And some products have been created
    And I visit the products page
    And I add some products to my basket
    And I click the "Basket" link
    And I click the "Checkout" button
    When I create a valid order
    Then I am shown the products page
