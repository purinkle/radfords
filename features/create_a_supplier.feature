Feature: Create a supplier
  In order to show customers where to buy products
  As an administrator
  I need to create a supplier

  Scenario: Create a supplier successfully
    Given I am on the new supplier page
    When I complete the form correctly
    And I submit the form
    Then I should be shown the page for the supplier
    And all the suppliers details should be listed

  Scenario: Fail to create a supplier
    Given I am on the new supplier page
    When I complete the form incorrectly
    And I submit the form
    Then I should be shown the new supplier page
    And an error message should be displayed