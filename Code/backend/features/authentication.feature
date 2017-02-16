Feature: Authentication
  As a user
  I want to sign in to the web app

  Scenario: Customer signs in with email
    Given I'm a customer
    When I sign in by email
    Then response is 201 Created
    And I get the access token

  Scenario: Customer signs in with wrong email
    Given I'm a customer
    When I sign in with wrong email
    Then I get 422 error

  Scenario: Support agent signs in with email
    Given I'm a support agent
    When I sign in by email
    Then response is 201 Created
    And I get the access token

  Scenario: Support agent signs in with wrong email
    Given I'm a support agent
    When I sign in with wrong email
    Then I get 422 error
