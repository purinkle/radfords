Feature: Show order
  In order to ship products
  As an administrator
  I need to see order details

  Scenario: Display order details
    Given I am logged in
    And an order has been created
    When I visit the order's page
    Then the order's details are shown
    And the order's contents are listed