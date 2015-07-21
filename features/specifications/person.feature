Feature: Person
  Background:
    Given I am logged in

  Scenario: View a person
    Given a "person" with the following data:
      | attribute   | value    |
      | name        | John Doe |
    When  I access created object url
    Then  I should see "John Doe"
