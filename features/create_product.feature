Feature: Create product
  In order to show what products can be bought
  As an administrator
  I need to create new products

  Scenario: Redirect from the new page to the sign in page
    Given I am a customer
    When I visit the new product page
    Then I am redirected to the "Sign In" page
