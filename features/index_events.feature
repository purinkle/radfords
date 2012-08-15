Feature: Index events
  In order to maintain events
  As an administrator
  I need to see all of the events

  Scenario: Display each event
    Given I am logged in
    And some events have been created
    When I click the "Events" link
    Then each event is displayed

  Scenario: Successfully delete event
    Given I am an administrator
    And an event has been created
    And I am looking at all of the events
    When I click the "Destroy" link
    Then there is a successful deletion flash
    And the event is not listed