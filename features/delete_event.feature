Feature: Delete event
  In order to keep events up-to-date
  As an administrator
  I need to delete events

  Scenario: Redirect to the sign in screen
    Given I am a customer
    When I am deleting an event
    Then the sign in page is shown

  Scenario: Display the confirmation page
    Given I am an administrator
    And some events have been created
    When I am deleting an event
    Then the confirmation page is shown
    And there is a "Delete Event" button
    And there is a "Cancel" link