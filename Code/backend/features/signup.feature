Feature: Sign up
  As a customer I want to sign up
  to be able to create tickets
  and to view status of previous requests.

  Scenario: Successful customer registration
    When I sign up as a customer
    Then I can access application

  Scenario: Customer already registered
    When I signed up previously
    And I sign up as a customer
    Then I get 422 error
    And I get "user is already signed up" error
