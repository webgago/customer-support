Feature: Add Ticket
  As a customer I want to create a ticket

  Scenario: Customer creates ticket
    Given I'm logged in as a customer
    When I create ticket
    Then response is 200 Ok

  Scenario: The params is invalid
    Given I'm logged in as a customer
    When I create ticket with invalid params
    Then I get 422 error
