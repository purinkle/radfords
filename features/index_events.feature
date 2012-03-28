Feature: Index events
  In order to maintain events
  As an administrator
  I need to see all of the events

  Scenario: Display each event
    Given I am logged in
    And some events have been created
    When I click the "Events" link
    Then each event is displayed

  Scenario: Paginate events
    Given I am logged in
    And some events have been created
    When I click the "Events" link
    Then the pagination section is displayed
    And the "Previous" link is disabled
    And the link to the second page is displayed
    And the "Next" link is displayed
