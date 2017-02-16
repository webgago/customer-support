Feature: Reset password
  As a user I want to reset my password
  in case I lost it

  Scenario: Reset password with existing email
    Given I am a customer
    When I request to reset password
    Then I get reset password instructions via email
    When I set new password
    Then response is 204 No Content
    And I can sign in using this password

