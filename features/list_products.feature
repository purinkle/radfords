Feature: List products
  In order to maintain products
  As an administrator
  I need to see a list of all the products

  Scenario: Redirect to the "Sign In" page
    Given I am a customer
    When I am looking at the products list
    Then I am redirected to the "Sign In" page

  Scenario: Show a "no products" message
    Given I am an administrator
    And no products have been created
    When I am looking at the products list
    Then the title is correct
    And a "no products" message is shown
    And a "New Product" link is shown

  Scenario: Link to the "New Product" page
    Given I am an administrator
    When I am looking at the products list
    And I click the "New Product" link
    Then the "New Product" page is shown