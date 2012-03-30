Feature: Index suppliers
  In order to maintain suppliers
  As an administrator
  I need to see all of the suppliers

  Scenario: Display each supplier
    Given I am logged in
    And some suppliers have been created
    When I click the "Where to buy" link
    Then each supplier is displayed

  Scenario: Display a "Delete" button
    Given I am logged in
    And some suppliers have been created
    When I click the "Where to buy" link
    Then a "Delete" button is displayed

  Scenario: Delete a supplier
    Given I am logged in
    And some suppliers have been created
    And I click the "Where to buy" link
    When I click a "Delete" button
    Then I am redirected back to the "Outlets" page
    And the supplier is no longer displayed
    And a success flash is displayed
