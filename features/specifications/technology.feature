Feature: Technology
  Background:
    Given I am logged in

  Scenario: View a technology
    Given a "technology" with the following data:
      | attribute | value                     |
      | name      | Ruby                      |
      | website   | https://www.ruby-lang.org |
    When  I access created object url
    Then  I should see "Ruby"
    And   I should see a link "https://www.ruby-lang.org" with href "https://www.ruby-lang.org"
