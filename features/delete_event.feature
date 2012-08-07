Feature: Delete event
  In order to keep events up-to-date
  As an administrator
  I need to delete events

  Scenario: Redirect to the sign in screen
    Given I am a customer
    When I am deleting an event
    Then the sign in page is shown