Feature: Edit supplier
  In order to keep suppliers up-to-date
  As an administrator
  I need to edit suppliers

  Scenario: Edit supplier successfully
    Given I am an administrator
    And some suppliers have been created
    And I am editing a supplier
    When I click the "Update Supplier" button
    Then a success flash is shown