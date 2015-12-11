Feature: Person
  Background:
    Given I am logged in
    And I have permissions with the following data:
      | model  | action   |
      | person | index    |
      | person | show     |
      | person | new      |
      | person | create   |
      | person | edit     |
      | person | update   |
      | person | delete   |
      | person | follow   |
      | person | unfollow |
      | person | like     |
      | person | unlike   |

  Scenario: View a person
    Given a "person" with the following data:
      | attribute | value                |
      | name      | John Doe |
    When  I access its url
    Then  I should see "John Doe"

  Scenario: Follow person
    Given a "person"
    And  I am on its url
    When I click on "Follow"
    Then I should see "Unfollow"

  Scenario: Unfollow person
    Given a "person"
    And  I am on its url
    And  I clicked on "Follow"
    When I click on "Unfollow"
    And  I should see "Follow"

  Scenario: Like person
    Given a "person"
    And  I am on its url
    When I click on "Like"
    Then I should see "You liked the person"
    And  I should see "Unlike"

  Scenario: Unlike person
    Given a "person"
    And  I am on its url
    And  I clicked on "Like"
    When I click on "Unlike"
    Then I should see "You're not liking the person"
    And  I should see "Like"
