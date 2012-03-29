Feature: Show product
  In order to check product details
  As an administrator
  I need to see individual products

  Scenario: Display the product's details
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I create a valid product
    Then the product's title is displayed
    And the product's description is displayed
    And an image of the product is displayed
    And the product's price is displayed
    And there is an "Edit" link
    And there is a "Back" link

  Scenario: Display the "Edit Product" page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    When I click the "Edit" link
    Then the "Edit Product" page is displayed

  Scenario: Display the "Products" page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    When I click the "Back" link
    Then the "Products" page is displayed

  Scenario: Display updated product details
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Edit" link
    When I update the product with valid attributes
    Then the updated title is displayed
    And the updated description is displayed
    And the updated image is displayed
    And the updated price is displayed

  Scenario: Display a "Delete" button
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I create a valid product
    Then a "Delete" button is displayed

  Scenario: Delete the product
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    When I click the "Delete" button
    Then the "Products" page is displayed
    And the product is not displayed

  Scenario: Display an "Add to Basket" button
    Given I am a customer
    And some products have been created
    And I visit the products page
    When I click the first product link
    Then an "Add to Basket" button is displayed
