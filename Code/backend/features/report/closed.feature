Feature: Report. Closed tickets

  Scenario: Support Agent gets report with all tickets closed in the last one month
    Given I'm logged in as a support agent
    When I get the report
    Then response is 200 Ok
