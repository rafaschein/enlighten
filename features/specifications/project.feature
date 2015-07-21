Feature: Project
  Background:
    Given I am logged in

  Scenario: View a project
    Given a "project" with the following data:
      | attribute   | value               |
      | name        | Test Project        |
      | description | Project description |
    When  I access created object url
    Then  I should see "Test Project"
