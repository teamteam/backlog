Feature: Backlog Item

  Background:
    Given I am logged in

  Scenario: Create
    Given I view the backlog
    When I add a backlog item
    And I view the backlog
    Then the backlog item should be in this week

