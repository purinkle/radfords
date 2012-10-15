Feature: Edit product
  Scenario: Not signed in
    Given I am not signed in
    When I edit a product
    Then I see the sign in page
    And I see a sign in message

  Scenario: Product doesn't exist
    Given I am signed in
    And no products have been created
    When I edit a product
    Then I see the list of products
    And I see an invalid product message
