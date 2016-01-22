Feature: Project
  Background:
    Given I am logged in
    And I have permissions with the following data:
      | model   | action   |
      | project | index    |
      | project | show     |
      | project | new      |
      | project | create   |
      | project | edit     |
      | project | update   |
      | project | delete   |
      | project | follow   |
      | project | unfollow |
      | project | like     |
      | project | unlike   |

  Scenario: View a project
    Given a "project" with the following data:
      | attribute   | value               |
      | name        | Test Project        |
      | description | Project description |
    When  I access its url
    Then  I should see "Test Project"

  Scenario: Follow project
    Given a "project"
    And  I am on its url
    When I click on "Follow"
    Then I should see "Unfollow"

  Scenario: Unfollow project
    Given a "project"
    And  I am on its url
    And  I clicked on "Follow"
    When I click on "Unfollow"
    And  I should see "Follow"

  Scenario: Like project
    Given a "project"
    And  I am on its url
    When I click on "Like"
    Then I should see "You're liking the project"
    And  I should see "Unlike"

  Scenario: Unlike project
    Given a "project"
    And  I am on its url
    And  I clicked on "Like"
    When I click on "Unlike"
    Then I should see "You're not liking the project"
    And  I should see "Like"
