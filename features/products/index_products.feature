Feature: Index products
  Scenario: No products exist
    Given I am signed in
    And no products exist
    When I go to the index products page
    Then I see a no products message

  Scenario: Products exist
    Given I am signed in
    And some products exist
    When I go to the index products page
    Then I see each product's title
    And I see each product's description
    And I see each product's photo

  Scenario: Show product
    Given I am signed in
    And a product exists
    And I am on the index products page
    When I follow the product's link
    Then I see the show product page

  Scenario: Edit product
    Given I am signed in
    And a product exists
    And I am on the index products page
    When I follow the "Edit" link
    Then I see the edit product page

  Scenario: Delete product
    Given I am signed in
    And a product exists
    And I am on the index products page
    When I follow the "Delete" link
    Then I see the delete product page

  Scenario: Visit the page from the delete product page
    Given I am signed in
    And a product exists
    And I am on the delete product page
    When I follow the "Cancel" link
    Then I see the index products page
