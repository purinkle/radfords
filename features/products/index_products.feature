Feature: Index products
  Scenario: Products exist
    Given I am signed in
    And some products exist
    When I go to the index products page
    Then I see each product's title
    And I see each product's description
    And I see each product's photo
