Feature: Events
  Scenario: Show event
    Given I am signed in
    And there is 1 event
    When I try to view the event
    Then I see the event's page
    And I see the name of the event
    And I see the location of the event
    And I see the date the event takes place on

  Scenario: New event
    Given I am signed in
    When I try to create an event
    Then I see the "New Event" page

  Scenario: Create valid event
    Given I am signed in
    When I create a valid event
    Then I see the event's page
    And I see a "You successfully created an event" notice

  Scenario: Create invalid event
    Given I am signed in
    When I create an invalid event
    Then I see the "New Event" page
    And I see a "Name can't be blank" message
    And I see a "Location can't be blank" message
    And I see a "Takes place on can't be blank" message

  Scenario: Edit event
    Given I am signed in
    And there is 1 event
    When I try to edit the event
    Then I see the "Edit Event" page
    And the name of the event is pre-populated
    And the location of the event is pre-populated
    And the date the event takes place on is pre-populated

  Scenario: Update event with valid data
    Given I am signed in
    And there is 1 event
    When I update the event with valid data
    Then I see the event's page
    And I see a "You successfully updated the event" notice

  Scenario: Update event with invalid data
    Given I am signed in
    And there is 1 event
    When I update the event with invalid data
    Then I see the "Edit Event" page
    And I see a "Name can't be blank" message
    And I see a "Location can't be blank" message
    And I see a "Takes place on can't be blank" message

  Scenario: Confirm event deletion
    Given I am signed in
    And there is 1 event
    When I delete the event
    Then I see the "Events" page
    And I see a "You successfully deleted the event" notice
    And I see 0 events

  Scenario: Delete an event that doesn't exist
    Given I am signed in
    When I delete an event that doesn't exist
    Then I see the "Events" page
    And I see a "We couldn't find the event you were looking for" alert

  Scenario: Don't sign in
    When I delete an event that doesn't exist
    Then I see the "Sign In" page
    And I see a "You need to sign in or sign up before continuing" alert
