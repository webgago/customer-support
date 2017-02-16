Feature: Reply to Ticket
  As a customer I want to create a ticket

  Scenario: Agent replies to ticket
    Given I'm logged in as a support agent
    When I reply to ticket
    Then response is 200 Ok

  Scenario: Agent replies to ticket and close it immediately
    Given I'm logged in as a support agent
    When I reply to ticket with status "closed"
    Then response is 200 Ok
    And ticket is closed

  Scenario: The params is invalid
    Given I'm logged in as a support agent
    When I create ticket with invalid params
    Then I get 422 error
