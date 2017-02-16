Feature: Show Ticket
  As a user
  I want to get a ticket by id

  Scenario: Customer gets own ticket
    Given I'm logged in as a customer
    When I get my ticket
    Then response is 200 Ok

  Scenario: Customer gets wrong ticket
    Given I'm logged in as a customer
    When I get wrong ticket
    Then I get 403 error

  Scenario: Get ticket for support agent
    Given I'm logged in as a support agent
    When I get a ticket by id
    Then response is 200 Ok
