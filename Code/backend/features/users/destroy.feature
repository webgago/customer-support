Feature: Destroy Users
  As a admin
  I want to destroy a user

  Scenario: Destroy users by admin
    Given I'm logged in as an admin
    When I destroy a user
    Then response is 204 No Content
    And user has been destroyed
