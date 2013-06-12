Feature: Shop page
  In order to decide what to buy
  As a customer
  I want to see all of the products available to me

  Scenario: Products available
    Given there are two products
    When I visit the shop
    Then I see the first product
    And I see the second product
