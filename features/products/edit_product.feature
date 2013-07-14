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

  Scenario: Load existing product
    Given I am signed in
    And a product exists
    When I go to the edit product page
    Then the "Title" field contains the product's title
    And the "Description" field contains the product's description
    And I see the product's photo

  Scenario: Cancel product update
    Given I am signed in
    And a product exists
    And I am on the show product page
    When I follow the "Edit" link
    And I press "Cancel"
    Then I see the show product page

  Scenario: Blank title
    Given I am signed in
    And a product exists
    When I save a product without a title
    Then I see the edit product page
    And I see a title missing message

  Scenario: Duplicate title
    Given I am signed in
    And some products exist
    When I save a product with a duplicate title
    Then I see the edit product page
    And I see a duplicate title message

  Scenario: Save a valid product
    Given I am signed in
    And a product exists
    When I save a product with valid data
    Then I see the show product page
    And I see a product saved message
