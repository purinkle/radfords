Feature: Index products
  Scenario: Not signed in
    Given I am not signed in
    When I go to the index products page
    Then I see the sign in page
    And I see a sign in message

  Scenario: Products exist
    Given I am signed in
    And some products exist
    When I go to the index products page
    Then I see each product's title
    And I see each product's description
    And I see each product's photo

  Scenario: Edit product
    Given I am signed in
    And a product exists
    And I am on the index products page
    When I follow the "Edit" link
    Then I see the edit product page
