Feature: Create product
  In order to display new products
  As an administrator
  I want to be able to create new products

  Scenario: Display a "New Product" link
    Given I am logged in
    When I click the "Products" link
    Then there is a "New Product" link

  Scenario: Display the "New Product" page
    Given I am logged in
    And I click the "Products" link
    When I click the "New Product" link
    Then the "New Product" page is displayed

  Scenario: Display a "Back" link
    Given I am logged in
    And I click the "Products" link
    When I click the "New Product" link
    Then there is a "Back" link

  Scenario: Display the "Product" page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I click the "Back" link
    Then the "Products" page is displayed

  Scenario: Redirect to a product page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I create a valid product
    Then I am shown a product page
    And a success flash is displayed

  Scenario: Stay on the new product page
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I create an invalid product
    Then I stay on the new product page

  Scenario: Display a "Title can't be blank" message
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I leave the title blank
    Then a "Title can't be blank" message is displayed

  Scenario: Display a "Description can't be blank" message
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I leave the description blank
    Then a "Description can't be blank" message is displayed

  Scenario: Display an "Image URL can't be blank" message
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I leave the image URL blank
    Then an "Image URL can't be blank" message is displayed

  Scenario: Display a "Price is not a number" message
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I enter a price that's not a number
    Then a "Price is not a number" message is displayed

  Scenario: Display a "Price must be greater than or equal to 0.01" message
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I enter a price that's less than 0.01
    Then a "Price must be greater than or equal to 0.01" message is displayed

  Scenario: Display a "Title has already been taken" message
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    And I create a valid product
    And I click the "Back" link
    And I click the "New Product" link
    When I create a valid product
    Then a "Title has already been taken" message is displayed

  Scenario: Display the number of errors
    Given I am logged in
    And I click the "Products" link
    And I click the "New Product" link
    When I create an invalid product
    Then the error count is displayed

