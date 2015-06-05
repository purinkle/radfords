Feature: Baskets

  Scenario:
    Given I don't have a basket
    When I view the basket
    Then I see the "Your Basket" page
    And I see a "Your basket is empty" message

  Scenario:
    Given a product exists
    And I have the product in my basket
    When I empty my basket
    Then I see the "Your Basket" page
    And I see a "Your basket is currently empty" notice

  Scenario: Add a product to my basket
    Given a product exists
    And I have the product in my basket
    And I am on the "Shop" page
    When I add the product to my basket
    Then I see the "Your Basket" page
    And I see the product in my basket twice

  Scenario: Remove all items from the basket
    Given a product exists
    And I have the product in my basket
    And I am viewing my basket
    When I remove the product from my basket
    Then I see the "Your Basket" page
    And I see a "Your basket is empty" message

  Scenario: Link to product page
    Given a product exists
    And I have the product in my basket
    And I am viewing my basket
    When I click on the product
    Then I see the product's page
