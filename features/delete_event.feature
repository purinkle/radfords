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

  Scenario: Redirect to the events index
    Given I am an administrator
    And some events have been created
    When I am deleting an invalid event
    Then the events index is shown
    And there is an invalid event flash

  Scenario: Succesfully delete event
    Given I am an administrator
    And some events have been created
    And I am deleting an event
    When I click the "Delete Event" button
    Then the events index is shown
    And there is a successful deletion flash
    And the event is not listed