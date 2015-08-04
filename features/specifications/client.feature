Feature: Client
  Background:
    Given I am logged in

  Scenario: View a client
    Given a "client" with the following data:
      | attribute | value                |
      | name      | ACME inc.            |
      | website   | https://www.acme.com |
    When  I access its url
    Then  I should see "ACME inc."
    And   I should see a link "https://www.acme.com" with href "https://www.acme.com"

  Scenario: Follow client
    Given a "client"
    And  I am on its url
    When I click on "Follow"
    Then I should see "UNFOLLOW"

  Scenario: Unfollow client
    Given a "client"
    And  I am on its url
    And  I clicked on "Follow"
    When I click on "Unfollow"
    And  I should see "FOLLOW"

  Scenario: Like client
    Given a "client"
    And  I am on its url
    When I click on "Like"
    Then I should see "You liked the client"
    And  I should see "UNLIKE"

  Scenario: Unlike client
    Given a "client"
    And  I am on its url
    And  I clicked on "Like"
    When I click on "Unlike"
    Then I should see "You're not liking the client"
    And  I should see "LIKE"
