Feature: Index events
  In order to maintain events
  As an administrator
  I need to see all of the events

  Scenario: Display each event
    Given I am logged in
    And some events have been created
    When I click the "Events" link
    Then each event is displayed
