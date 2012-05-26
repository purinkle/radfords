Feature: Index orders
  In order to ship products
  As an administrator
  I need to see all the products

  Scenario: Display a list of all orders
    Given I am logged in
    And several orders have been created
    When I visit the order index
    Then each order is shown