Feature: Edit product
  Scenario: Not signed in
    Given I am not signed in
    When I go to the edit product page
    Then I see the sign in page
    And I see a sign in message

  Scenario: Product doesn't exist
    Given I am signed in
    And no products exist
    When I go to the edit product page
    Then I see the index products page
    And I see an invalid product message
