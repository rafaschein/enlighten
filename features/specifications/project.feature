Feature: Project
  Background:
    Given I am logged in

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
    Then I should see "UNFOLLOW"

  Scenario: Unfollow project
    Given a "project"
    And  I am on its url
    And  I clicked on "Follow"
    When I click on "Unfollow"
    And  I should see "FOLLOW"

  Scenario: Like project
    Given a "project"
    And  I am on its url
    When I click on "Like"
    Then I should see "You liked the project"
    And  I should see "UNLIKE"

  Scenario: Unlike project
    Given a "project"
    And  I am on its url
    And  I clicked on "Like"
    When I click on "Unlike"
    Then I should see "You're not liking the project"
    And  I should see "LIKE"
