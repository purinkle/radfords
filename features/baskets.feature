Feature: Baskets

  Scenario:
    Given I don't have a basket
    When I view the basket
    Then I see the "Shop" page
    And I see an "Invalid basket" alert

  Scenario:
    Given I am signed in
    And a product exists
    And I have the product in my basket
    When I empty my basket
    Then I see the "Shop" page
    And I see a "Your basket is currently empty" notice

  Scenario:
    Given I am signed in
    And a product exists
    And I have the product in my basket
    And I am on the "Shop" page
    When I add the product to my basket
    Then I see the "Basket" page
    And I see the product in my basket twice
