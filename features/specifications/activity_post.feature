Feature: Activity
  Background:
    Given I am logged in
  
  Scenario: Post text activity on person
    Given a "person" with the following data:
      | attribute | value    |
      | name      | John Doe |
    And I have permissions with the following data:
      | model    | action |
      | person   | show   |
      | post     | new    |
      | post     | create |
      | activity | new    |
      | activity | create |
    When  I access its url
    And   I type "This is a sample post" on the filed with "Have something nice to say?" placeholder
    When  I click on the "submit-post" button
    Then  I should see "This is a sample post"

  Scenario: Post text activity on project
    Given a "project" with the following data:
      | attribute   | value               |
      | name        | Test Project        |
      | description | Project description |
    And I have permissions with the following data:
      | model    | action |
      | project  | show   |
      | post     | new    |
      | post     | create |
      | activity | new    |
      | activity | create |
    When  I access its url
    And   I type "This is a sample post" on the filed with "Have something nice to say?" placeholder
    When  I click on the "submit-post" button
    Then  I should see "This is a sample post"

  Scenario: Post text activity on technology
    Given a "technology" with the following data:
      | attribute | value                     |
      | name      | Ruby                      |
      | website   | https://www.ruby-lang.org |
    And I have permissions with the following data:
      | model      | action |
      | technology | show   |
      | post       | new    |
      | post       | create |
      | activity   | new    |
      | activity   | create |
    When  I access its url
    And   I type "This is a sample post" on the filed with "Have something nice to say?" placeholder
    When  I click on the "submit-post" button
    Then  I should see "This is a sample post"
