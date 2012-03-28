Feature: Index suppliers
  In order to maintain suppliers
  As an administrator
  I need to see all of the suppliers

  Scenario: Display each supplier
    Given I am logged in
    And some suppliers have been created
    When I click the "Where to buy" link
    Then each supplier is displayed
