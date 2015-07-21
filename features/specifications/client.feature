Feature: Client
  Background:
    Given I am logged in

  Scenario: View a client
    Given a "client" with the following data:
      | attribute | value                |
      | name      | ACME inc.            |
      | website   | https://www.acme.com |
    When  I access created object url
    Then  I should see "ACME inc."
    And   I should see a link "https://www.acme.com" with href "https://www.acme.com"
