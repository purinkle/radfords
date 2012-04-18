Feature: Destroy basket
  In order to keep my basket up-to-date
  As a customer
  I need to empty my basket

  Scenario: Empty basket from "Basket"
    Given I am a customer
    And some products have been created
    And I visit the products page
    And I click an "Add to Cart" button
    When I click "Empty basket"
    Then I am redirected to "Products"
    And "Your basket is currently empty" is displayed
