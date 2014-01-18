Feature: Orders

  Scenario:
    Given I have an empty basket
    When I visit the "New order" page
    Then I see the "Shop" page
    And I see a "Your basket is empty" notice

    #  Scenario:
    #    Given a product exists
    #    And I have the product in my basket
    #    And I have checked out my basket
    #    When I create the order
    #    Then I see the "Shop" page
    #    And I see a "Thank you for your order" notice

    #  Scenario:
    #    Given a product exists
    #    And I have the product in my basket
    #    And I have checked out my basket
    #    When I create the order incorrectly
    #    Then I see the "New order" page
    #    And I see some validation messages
