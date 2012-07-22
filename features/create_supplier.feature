Feature: Create supplier
  In order to show where products can be bought
  As an administrator
  I need to create new suppliers

  Scenario: Display an address field
    Given I am logged in
    And I click the "Where to buy" link
    When I click the "New supplier" link
    Then an address field is displayed

  Scenario: Cancel new supplier
    Given I am logged in
    And I am on the new supplier page
    When I click the "Cancel" link
    Then the outlet page is shown