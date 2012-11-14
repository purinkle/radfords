Feature: Show product
  Scenario: Not signed in
    Given I am not signed in
    When I go to the show product page
    Then I see the sign in page
    And I see a sign in message

  Scenario: Load existing product
    Given I am signed in
    And a product exists
    When I go to the show product page
    Then I see the product's title
    And I see the product's description
    And I see the product's photo
