Feature: Change Status Ticket
  As a support agent
  I want to get close and/or reopen a ticket

  Scenario: Support Agent closes a ticket
    Given I'm logged in as a support agent
    When I close a ticket
    Then response is 200 Ok
    And ticket is closed

  Scenario: Support Agent reopen closed ticket
    Given I'm logged in as a support agent
    When I reopen closed ticket
    Then response is 200 Ok
    And ticket is open
