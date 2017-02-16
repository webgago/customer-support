Feature: List Tickets
  As a user
  I want to get a list of tickets

  Scenario: List tickets for customer
    Given I'm logged in as a customer
    When I get the list of tickets
    Then response is 200 Ok
    And I view only my requests
    And result is paginated

  Scenario: List tickets for support agent
    Given I'm logged in as a support agent
    When I get the list of tickets
    Then response is 200 Ok
    And I view all requests
    And result is paginated
