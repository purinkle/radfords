Feature: Products
  Scenario: Create invalid product
    Given I am signed in
    When I create an invalid product
    Then I see the "New Product" page
    And I see a "Title can't be blank" message
