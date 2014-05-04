Feature: Order
  Scenario: Order exists
    Given I am signed in
    And an order exists
    When I view the order
    Then I see the order's name
    And I see the order's address
    And I see the order's email
