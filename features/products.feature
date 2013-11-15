Feature: Products
  Scenario: Create invalid product
    Given I am signed in
    When I create an invalid product
    Then I see the "New Product" page
    And I see a "Title can't be blank" message

    #  Scenario:
    #    Given I am signed in
    #    And a product exists
    #    And I have the product in my basket
    #    And I am deleting the product
    #    When I delete the product
    #    Then I see the "Delete Product" page
    #    And I see a "Line Items present" error

  Scenario:
    Given I am signed in
    And a product exists
    And I am deleting the product
    And someone else deletes the product
    When I delete the product
    Then I see the "Products" page
    And I see a "We couldn't find that product" alert
