Feature: List Users
  As a admin
  I want to get a list of users

  Scenario: List users for admin
    Given I'm logged in as an admin
    When I get the list of users
    Then response is 200 Ok
    And I view all requests
    And result is paginated
