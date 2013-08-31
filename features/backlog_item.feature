Feature: Backlog Item

  Background:
    Given I am logged in

  Scenario: Create
    Given I view the backlog
    When I add a backlog item
    And I view the backlog
    Then the backlog item should be in this week

  Scenario: Update
    Given a backlog item exists
    And I view the backlog
    When I update the backlog item
    Then the backlog item should be updated

  Scenario: Delete
    Given a backlog item exists
    And I view the backlog
    When I delete the backlog item
    Then the backlog item should not be in this week
