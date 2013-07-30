Feature: Suppliers

  Scenario: Delete supplier
    Given I am signed in
    And there is 1 supplier
    When I delete the supplier
    Then I see the "Outlets" page
    And I see a "You successfully deleted the supplier" notice
    And I see 0 suppliers

  Scenario: New supplier
    Given I am signed in
    When I try to create a supplier
    Then I see the "New Supplier" page

  Scenario: Create valid supplier
    Given I am signed in
    When I create a valid supplier
    Then I see the "Outlets" page
    And I see a "You successfully created a supplier" notice

  Scenario: Create invalid supplier
    Given I am signed in
    When I create an invalid supplier
    Then I see the "New Supplier" page
    And I see a "Name can't be blank" message
    And I see a "Address can't be blank" message
    And I see a "Telephone number can't be blank" message

  Scenario: Edit supplier
    Given I am signed in
    And there is 1 supplier
    When I try to edit the supplier
    Then I see the "Edit Supplier" page
    And the supplier's name is pre-populated
    And the supplier's address is pre-populated
    And the supplier's website is pre-populated
    And the supplier's telephone number is pre-populated

  Scenario: Update supplier with valid data
    Given I am signed in
    And there is 1 supplier
    When I update the supplier with valid data
    Then I see the "Outlets" page
    And I see a "You successfully updated the supplier" notice

  Scenario: Update supplier with invalid data
    Given I am signed in
    And there is 1 supplier
    When I update the supplier with invalid data
    Then I see the "Edit Supplier" page
    And I see a "Name can't be blank" message
    And I see a "Address can't be blank" message
    And I see a "Telephone number can't be blank" message
