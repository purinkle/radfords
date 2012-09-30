Feature: Create product
  In order to show what products can be bought
  As an administrator
  I need to create new products

  Scenario: Redirect from the new page to the sign in page
    Given I am a customer
    When I visit the new product page
    Then I am redirected to the "Sign In" page

  Scenario: Show the "New Product" form
    Given I am an administrator
    When I visit the new product page
    Then there is a "Title" field
    And there is a "Description" field
    And there is an "Image URL" field
    And there is a "Create Product" button
    And there is a "Cancel" link

  Scenario: Show a "Title can't be blank" error
    Given I am an administrator
    And I visit the new product page
    When I leave the "Title" field blank
    And I submit the "New Product" form
    Then I stay on the "New Product" page
    And there is a "Title can't be blank" error
