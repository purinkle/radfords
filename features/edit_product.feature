Feature: Edit product
  In order to keep products up-to-date
  As an administrator
  I need to edit product details

  Scenario: Edit the product from the product's page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    When I click the "Edit" link
    Then the product's title is displayed
    And the product's description is displayed
    And the product's image URL is displayed
    And the product's price is displayed
    And a "Show" link is displayed

  Scenario: Edit a product from the "Products" page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Back" link
    When I click an "Edit" link
    Then the product's title is displayed
    And the product's description is displayed
    And the product's image URL is displayed
    And the product's price is displayed
    And a "Show" link is displayed

  Scenario: Change a product
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Edit" link
    When I update the product with valid attributes
    Then the updated product's page is displayed

  Scenario: Show the product
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Edit" link
    When I click the "Show" link
    Then the product's page is displayed

  Scenario: Display a "Back" link
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    When I click the "Edit" link
    Then a "Back" link is displayed

  Scenario: Link to the products index
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Edit" link
    When I click the "Back" link
    Then the products index is displayed

  Scenario: Stay on the edit product page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Edit" link
    When I update the product with invalid attributes
    Then I stay on the edit product page

  Scenario: Display a "Title can't be blank" message
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Edit" link
    When I update the product with a blank title
    Then a "Title can't be blank" message is displayed

  Scenario: Display a "Description can't be blank" message
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Edit" link
    When I update the product with a blank description
    Then a "Description can't be blank" message is displayed

  Scenario: Display an "Image URL can't be blank" message
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Edit" link
    When I update the product with a blank image URL
    Then an "Image URL can't be blank" message is displayed
