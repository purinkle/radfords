Feature: Show product
  Scenario: Not signed in
    Given I am not signed in
    And a product exists
    When I go to the show product page
    Then I see the product's title
    And I see the product's description
    And I see the product's photo
    But I don't see the product admin controls

  Scenario: Product doesn't exist
    Given I am signed in
    And no products exist
    When I go to the show product page
    Then I see the index products page
    And I see an invalid product message

  Scenario: Load existing product
    Given I am signed in
    And a product exists
    When I go to the show product page
    Then I see the product's title
    And I see the product's description
    And I see the product's photo

  Scenario: List products
    Given I am signed in
    And a product exists
    And I am on the show product page
    When I follow the "Back" link
    Then I see the index products page

  Scenario: Edit product
    Given I am signed in
    And a product exists
    And I am on the show product page
    When I follow the "Edit" link
    Then I see the edit product page

  Scenario: Delete product
    Given I am signed in
    And a product exists
    And I am on the show product page
    When I follow the "Delete" link
    Then I see the delete product page
