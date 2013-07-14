Feature: Application footer

  Scenario: Administrator is signed in
    Given I am signed in
    When I go to the homepage
    Then I don't see the "Sign in" link
