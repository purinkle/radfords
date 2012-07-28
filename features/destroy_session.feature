Feature: Destroy session
  In order to stop normal users from editing data
  As an administrator
  I need to be able to sign out

  Scenario: Sign out successfully
    Given I am an administrator
    When I click the "Sign out" link
    Then a success flash is shown