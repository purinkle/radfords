Feature: Edit a supplier
  In order to keep supplier details up to date
  As a supplier
  I need to edit suppliers

  Scenario: Access the edit supplier page
    Given I am on the show supplier page
    When I click the edit supplier link
    Then I should be shown the edit supplier page

  Scenario: Change a suppliers details correctly
    Given I am on the edit supplier page
    When I complete the form with correct information
    And I submit the form
    Then the should be shown the show supplier page
    And a success message should be displayed