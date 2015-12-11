Feature: Technology
  Background:
    Given I am logged in
    And I have permissions with the following data:
      | model      | action   |
      | technology | index    |
      | technology | show     |
      | technology | new      |
      | technology | create   |
      | technology | edit     |
      | technology | update   |
      | technology | delete   |
      | technology | follow   |
      | technology | unfollow |
      | technology | like     |
      | technology | unlike   |

  Scenario: View a technology
    Given a "technology" with the following data:
      | attribute | value                     |
      | name      | Ruby                      |
      | website   | https://www.ruby-lang.org |
    When  I access its url
    Then  I should see "Ruby"
    And   I should see a link "https://www.ruby-lang.org" with href "https://www.ruby-lang.org"

  Scenario: Follow technology
    Given a "technology"
    And  I am on its url
    When I click on "Follow"
    Then I should see "Unfollow"

  Scenario: Unfollow technology
    Given a "technology"
    And  I am on its url
    And  I clicked on "Follow"
    When I click on "Unfollow"
    And  I should see "Follow"

  Scenario: Like technology
    Given a "technology"
    And  I am on its url
    When I click on "Like"
    Then I should see "You liked the technology"
    And  I should see "Unlike"

  Scenario: Unlike technology
    Given a "technology"
    And  I am on its url
    And  I clicked on "Like"
    When I click on "Unlike"
    Then I should see "You're not liking the technology"
    And  I should see "Like"
