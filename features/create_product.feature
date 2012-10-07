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
    When I visit the new product page
    And I leave the "Title" field blank
    And I submit the "New Product" form
    Then I stay on the "New Product" page
    And there is a "Title can't be blank" error

  Scenario: Show a "Title has already been taken" error
    Given I am an administrator
    When I visit the new product page
    And I use an existing title
    And I submit the "New Product" form
    Then I stay on the "New Product" page
    And there is a "Title has already been taken" error

  Scenario: Show a "product was created successfully" message
    Given I am an administrator
    When I visit the new product page
    And I create a valid product
    Then I am redirected to the product's page
    And there is a "product was created successfully" message

  Scenario: Link to the "Products" page
    Given I am an administrator
    When I visit the new product page
    And I click the "Cancel" link
    Then the "Products" page is shown
