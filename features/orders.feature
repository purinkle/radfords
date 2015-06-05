Feature: Orders

  Scenario:
    Given I have an empty basket
    When I visit the "New order" page
    Then I see the "Shop" page
    And I see a "Your basket is empty" notice

  Scenario:
    Given a product exists
    And I have the product in my basket
    And I have checked out my basket
    When I create the order
    Then I see the "Home" page
    And I see a "Thank you" message

  Scenario:
    Given a product exists
    And I have the product in my basket
    And I have checked out my basket
    When I create the order incorrectly
    Then I see the "New order" page
    And I see some validation messages

  Scenario: Order exists
    Given I am signed in
    And an order exists
    When I view the orders
    Then I see the order
